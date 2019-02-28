module ApplicationHelper
    def user_name
        return "" unless session[:user_id]
        User.find(session[:user_id]).name
    end
end
