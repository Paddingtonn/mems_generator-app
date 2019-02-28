var path = require('path');
var Html = require('html-webpack-plugin');

module.exports = {
    entry: "./js/app.jsx",
    output: {
        filename: "/private/var/www/my_ruby_project/app/views/home/index.html.erb",
        path: path.resolve(__dirname, 'build')
    },
    devServer: {
        inline: true,
        contentBase: './',
        port: 3001
    },
    mode: 'development',
    watch: true,
    devtool: 'source-map',
    module: {
        rules: [
            {
                test: /\.(ttf|eot|woff|svg)$/,
                use: {
                    loader: 'file-loader',
                    options: {
                        name: '[name].[ext]',
                        publicPath: 'fonts',
                        outputPath: 'fonts'
                    }
                }
            },
            {
                test: /\.(jpg|jpeg|gif|png|csv)$/,
                use: {
                    loader: 'file-loader',
                    options: {
                        name: '[name].[ext]',
                        publicPath: 'images',
                        outputPath: 'images'
                    }
                }
            },
            {
                test: /\.jsx$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: ['es2015', 'stage-2', 'react']
                    }
                }
            },
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader']
            },
            {
                test: /\.scss$/,
                use: ['style-loader', 'css-loader', 'sass-loader']
            }

        ]
    },
    plugins: [
        new Html({
            filename: 'index.html',
            template: './index.html',
        })
    ]
};