require 'spec_helper'

describe "Specifications Of Search Tweets By Hash Tag" do

   describe "connection establishment to Twitter account" do
       it "should return valid Twitter object if connected" do
         @client = TwitterWrapper.get_client
         @client.should be_true
       end
   end

   describe "#get_hash_tag" do
      it "should say 'Please Enter HashTag'" do
        output = `ruby start_search.rb`
        output.should include("Please Enter HashTag")
      end

      it "should receive 'test' as an input to HashTag" do
        fake_stdin("test") do
          puts "\n\nPlease Enter 'Test' as HashTag"
          input = STDIN.gets.to_s.chomp.strip
          input.should == "Test"
        end
      end
   end

   describe "#get_recent_tweets" do
     before :all do
       @tweet  = Tweet.new
       @tweets = @tweet.get_recent_tweets("test")
     end

     it "should pull down the recent 20 tweets" do
       @tweets.count <= 20
     end

     it "should contain the HashTag in the tweets" do
       @tweets.first.text.include?("#test") == true
     end
   end


   describe "#display_tweets" do
     before :all do
       @tweet  = Tweet.new
       @tweets = @tweet.get_recent_tweets("test")
     end

     it "should display tweets" do
       @tweet.should respond_to(:display_tweets)
     end
   end
end