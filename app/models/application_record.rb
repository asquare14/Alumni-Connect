class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Imports the Google Cloud client library
  require "google/cloud/language"
  
  # Instantiates a client
  language = Google::Cloud::Language.new
  
  # The text to analyze
  text = "You are horrible!"
  
  # Detects the sentiment of the text
  response = language.analyze_sentiment content: text, type: :PLAIN_TEXT
  
  # Get document sentiment from response
  sentiment = response.document_sentiment
  
  puts "Text: #{text}"
  puts "Score: #{sentiment.score}, #{sentiment.magnitude}"
end
