require "mini_magick"

class ShoesController < ApplicationController
    PICTURES_DIRECTORY = "/var/www/my_ruby_project/public"
    before_action :check_login

    def create
        @original_filename = params[:picture].original_filename
        @filename = SecureRandom.uuid
        @title = params[:title]

        shoe = Shoe.new
        shoe.filename = @filename
        shoe.original_filename = @original_filename
        shoe.title = @title

        filename = "#{PICTURES_DIRECTORY}/#{@filename}"
        File.open(filename, "wb") do |file| 
            file.write(params[:picture].read)
        end
        
        # params[:picture].rewind
        # response = Faraday.post('http://localhost:3000/memes',
        #     text: params[:text],
        #     image: params[:picture].read
        # )

        conn = Faraday.new(ENV.fetch("MEMS_GENERATOR_HOST")) do |f|
            f.request :multipart
            f.request :url_encoded
            f.adapter :net_http # This is what ended up making it work
        end
        
        payload = { image: Faraday::UploadIO.new(
            filename, 'image/jpeg'), text: params[:text] }
        
        response = conn.post('/memes', payload)
    
        thumbnail = "#{filename}-thumbnail"
        image = MiniMagick::Image.open(filename)
        image.resize "x100"
        image.write thumbnail

        filename = "#{PICTURES_DIRECTORY}/#{@filename}"
        File.open(filename, "wb") do |file| 
            file.write(response.body)
        end

        shoe.thumbnail_filename = "#{@filename}-thumbnail"
        shoe.save!

    end

    def show
        @shoe = Shoe.find(params[:id])
    end

    def index
        @pictures_list = Shoe.all
    end

    def destroy
        @deleted_shoe = Shoe.find(params[:id])
        @deleted_shoe.destroy

        @pictures_list = Shoe.all
        render 'shoes/index'
        
    end

    private 
    def check_login
        if !session[:user_id] 
            session[:message] = "Sorry, you need to be loged in!"
            redirect_to login_path
        end
    end
end
