#############################################################################
#This is the interface to the user that starts the execution

require_relative "tweet"

tweet = Tweet.new
tweet.get_hash_tag
#############################################################################