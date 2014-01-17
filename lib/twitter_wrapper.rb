#TwitterWrapper Class establishes the communication with Twitter using Twitter API
#This class can also be encapsulated inside a Module for future use

class TwitterWrapper
    require "rubygems"
    require 'twitter'
    require 'yaml'
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE



    #This method returns a logged-in Twiter user/client.
    #It uses twitter configurations for authorization and authentication
    #Pre-requisites for Twitter API integration:
    #Sign up to the Twiter A/C and register the App to the url https://dev.twitter.com.
    def self.get_client
      begin
        twitter_config = YAML::load_file("./config/twitter_config.yml")
        config = {
          consumer_key: twitter_config['config']['consumer_key'],
          consumer_secret: twitter_config['config']['consumer_secret'],
          access_token: twitter_config['config']['access_token'],
          access_token_secret: twitter_config['config']['access_token_secret']
         }
        Twitter::REST::Client.new(config)
      rescue Exception => e
        puts "\nThere Was An Error While Connecting To Twitter: #{e.message}"
      end
    end
end