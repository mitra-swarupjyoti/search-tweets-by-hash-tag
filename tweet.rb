#This Class accepts the Hash Tag from a User as an input
#It then retrieves all the latest Tweets that matches the Hash Tag entered
#Finally, It displays the recent 20 tweets to the user.

class Tweet
  require "./lib/twitter_wrapper"

  #This method accepts Hash Tag from user as an Input
  def get_hash_tag
   begin
      hash_tag = ""
      while hash_tag.strip.length == 0 do
        puts "\n\nPlease Enter HashTag"
        STDOUT.flush
        hash_tag = STDIN.gets.chomp
        puts "You Have Entered The HashTag: ##{hash_tag}" unless hash_tag.strip.length == 0
      end
      @tweets = get_recent_tweets( hash_tag )
      display_tweets( hash_tag, @tweets )
    rescue Exception => e
      puts "\nThere was an error while accepting Hash Tag as an input: #{e.message}"
    end
  end




  #This method pulls down all the latest 20 tweets that are matched against the Hash Tag entered
  def get_recent_tweets hash_tag
    begin
      connect_to_twitter
      @client.search( "#"+hash_tag, count: 20, result_type: "recent" ).take(20)
    rescue Exception => e
      puts "\nThere was an error while retrieving tweets: #{e.message}"
    end
  end




  #This method displays all the tweets from the search results
  #It also displays date, time, user name for the tweets
  def display_tweets hash_tag, tweets
    begin
      puts "\n\n=======Displaying Recent 20 Tweets That Include the Hash Tag: ##{hash_tag}========\n\n"
      tweets.each_with_index do |tweet, index|
        puts "\n#{index + 1}. \n User: #{tweet.user.screen_name}"
        puts "\n Tweeted On: #{tweet.created_at.strftime('%d%b, %Y at %I:%M%p')}"
        puts "\n\n Tweet: \n  #{tweet.text}\n\n"
        puts "---------------------------------------------------------------------------"
      end
      puts "\n\n==========================Tweets End Here====================================\n\n\n\n"
    rescue Exception => e
      puts "\nThere was an error while displaying tweets: #{e.message}"
    end
  end






  private

  #This method hooks up to the Twitter API for communicating to the Twitter
  def connect_to_twitter
    begin
      @client = TwitterWrapper.get_client
    rescue Exception => e
      puts "\nThere was an error while connecting to Twitter: #{e.message}"
    end
  end
end


