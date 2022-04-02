require 'dotenv'
require 'json'
Dotenv.loaded

class FflogsController < ApplicationController

    # Create a route that sends the client id and client secert to the fflogs token generation api
    # Client id and client secret are in the .env file
    # example curl request: curl -u {client_id}:{client_secret} -d grant_type=client_credentials https://www.fflogs.com/oauth/token

    # GET /fflogs/token
    def token
        client_id = ENV['CLIENT_ID']
        client_secret = ENV['CLIENT_SECRET']
        url = "https://www.fflogs.com/oauth/token"
        response = RestClient.post(url, {grant_type: "client_credentials", client_id: client_id, client_secret: client_secret})
        render json: response
    end

end