require 'open-uri'
require 'nokogiri'

def open_weather_report(city)
  puts "Opening the weather report for #{city}."
  begin
    doc = Nokogiri::HTML(URI.open("https://www.weather-forecast.com/locations/#{city}/forecasts/latest"))
    weather_elements = doc.css(".b-forecast__table-description-content")
    weather_elements.each do |element|
      puts element.text.strip
    end
  rescue StandardError => e
    puts "Failed to fetch weather information. Please try again later."
  end
end

def father_of_the_nation_of_bangladesh
  puts "The Father of the Nation Bangabandhu Sheikh Mujibur Rahman is the architect of independent Bangladesh."
  puts "He played a vital role in the liberation movement and is revered as a national hero."
end

def get_ip_address
  begin
    ip_address = URI.open("https://checkip.amazonaws.com").read
    puts "Your IP address is: #{ip_address}"
  rescue StandardError => e
    puts "Failed to retrieve IP address. Please try again later."
  end
end

def open_wikipedia
  begin
    system("start https://www.wikipedia.org/")
  rescue StandardError => e
    puts "Failed to open Wikipedia. Please try again later."
  end
end

def search_on_wikipedia
  puts "What would you like to search on Wikipedia?"
  query = gets.chomp
  begin
    system("start https://en.wikipedia.org/wiki/#{query}")
  rescue StandardError => e
    puts "Failed to search on Wikipedia. Please try again later."
  end
end

def search_on_youtube
  puts "What would you like to search on YouTube?"
  query = gets.chomp
  begin
    system("start https://www.youtube.com/results?search_query=#{query}")
  rescue StandardError => e
    puts "Failed to search on YouTube. Please try again later."
  end
end

def play_on_youtube
  puts "What would you like to play on YouTube?"
  query = gets.chomp
  begin
    system("start https://www.youtube.com/results?search_query=#{query}")
  rescue StandardError => e
    puts "Failed to play on YouTube. Please try again later."
  end
end

def open_youtube
  begin
    system("start https://www.youtube.com/")
  rescue StandardError => e
    puts "Failed to open YouTube. Please try again later."
  end
end

def get_date_and_time
  current_date_time = Time.now.strftime("%d-%m-%Y %H:%M:%S")
  puts "The current date and time is: #{current_date_time}"
end

def get_local_time
  current_time = Time.now.strftime("%H:%M:%S")
  puts "The current local time is: #{current_time}"
end

def get_today_date
  today_date = Time.now.strftime("%d-%m-%Y")
  puts "Today's date is: #{today_date}"
end

def open_facebook
  begin
    system("start https://www.facebook.com/")
  rescue StandardError => e
    puts "Failed to open Facebook. Please try again later."
  end
end

def open_facebook_profile
  begin
    system("start https://www.facebook.com/profile.php")
  rescue StandardError => e
    puts "Failed to open Facebook profile. Please try again later."
  end
end

def open_facebook_settings
  begin
    system("start https://www.facebook.com/settings")
  rescue StandardError => e
    puts "Failed to open Facebook settings. Please try again later."
  end
end

def open_facebook_reel
  begin
    system("start https://www.facebook.com/reels")
  rescue StandardError => e
    puts "Failed to open Facebook Reels. Please try again later."
  end
end

def open_facebook_messenger
  begin
    system("start https://www.messenger.com/")
  rescue StandardError => e
    puts "Failed to open Facebook Messenger. Please try again later."
  end
end

def open_facebook_video
  begin
    system("start https://www.facebook.com/videos")
  rescue StandardError => e
    puts "Failed to open Facebook videos. Please try again later."
  end
end

def open_facebook_notification
  begin
    system("start https://www.facebook.com/notifications")
  rescue StandardError => e
    puts "Failed to open Facebook notifications. Please try again later."
  end
end

def open_google_browser
  begin
    system("start https://www.google.com/")
  rescue StandardError => e
    puts "Failed to open Google. Please try again later."
  end
end

def open_google_mail
  begin
    system("start https://mail.google.com/")
  rescue StandardError => e
    puts "Failed to open Google Mail. Please try again later."
  end
end

def open_google_earth
  begin
    system("start https://www.google.com/earth/")
  rescue StandardError => e
    puts "Failed to open Google Earth. Please try again later."
  end
end

def google_earth_specify_city
  puts "Which city do you want to see on Google Earth?"
  city = gets.chomp.downcase
  begin
    system("start https://www.google.com/earth/geo/#{city}/")
  rescue StandardError => e
    puts "Failed to open Google Earth for the specified city. Please try again later."
  end
end

def open_google_map
  begin
    system("start https://www.google.com/maps/")
  rescue StandardError => e
    puts "Failed to open Google Map. Please try again later."
  end
end

def google_map_specify_city
  puts "Which city do you want to see on Google Map?"
  city = gets.chomp.downcase
  begin
    system("start https://www.google.com/maps/place/#{city}/")
  rescue StandardError => e
    puts "Failed to open Google Map for the specified city. Please try again later."
  end
end

def google_translate_specify_word
  puts "Which word or sentence do you want to translate to English?"
  text = gets.chomp
  begin
    system("start https://translate.google.com/#auto/en/#{text}")
  rescue StandardError => e
    puts "Failed to open Google Translate. Please try again later."
  end
end

def tell_joke
  begin
    doc = Nokogiri::HTML(URI.open("https://www.jokes4us.com/miscellaneousjokes/cleanjokes.html"))
    joke_elements = doc.css("div[style='font-size:medium;']")
    joke_elements.each do |element|
      puts element.text.strip
    end
  rescue StandardError => e
    puts "Failed to fetch a joke. Please try again later."
  end
end

def translate_languages
  puts "Which language do you want to translate from?"
  from_language = gets.chomp.downcase

  puts "Which language do you want to translate to?"
  to_language = gets.chomp.downcase

  puts "What do you want to translate?"
  text = gets.chomp

  begin
    system("start https://translate.google.com/##{from_language}/#{to_language}/#{text}")
  rescue StandardError => e
    puts "Failed to open Google Translate. Please try again later."
  end
end

def available_commands
  puts "Available commands:"
  puts "- Weather: Get the weather report of a city"
  puts "- Father of the Nation of Bangladesh: Learn about the Father of the Nation of Bangladesh"
  puts "- IP address: Get your IP address"
  puts "- Opening Wikipedia: Open the Wikipedia homepage"
  puts "- Search on Wikipedia: Search for a specific topic on Wikipedia"
  puts "- Search on YouTube: Search for a video on YouTube"
  puts "- Play on YouTube: Search and play a video on YouTube"
  puts "- Open YouTube: Open the YouTube homepage"
  puts "- Date and Time: Get the current date and time"
  puts "- Today's Time: Get the current local time"
  puts "- Today's Date: Get today's date"
  puts "- Opening Facebook: Open the Facebook homepage"
  puts "- Facebook Profile: Open your Facebook profile"
  puts "- Facebook Settings: Open the Facebook settings page"
  puts "- Facebook Reels: Open Facebook Reels"
  puts "- Facebook Messenger: Open Facebook Messenger"
  puts "- Facebook Video: Open Facebook videos"
  puts "- Facebook Notification: Open Facebook notifications"
  puts "- Opening Google: Open the Google homepage"
  puts "- Opening Gmail: Open Google Mail"
  puts "- Google Earth: Open Google Earth"
  puts "- Google City: View a city on Google Earth"
  puts "- Google Map: Open Google Map"
  puts "- City from Map: View a city on Google Map"
  puts "- Translate to English: Translate a word or sentence to English"
  puts "- Listen a Joke: Listen to a joke"
  puts "- Translation between two languages: Translate text between two languages"
  puts "- What can you do: Get the list of available commands"
  puts "- Who made you: Know who made this digital assistant"
  puts "- What is your name: Know the name of this digital assistant"
  puts "- Ask: Ask a computational or geographical question"
end

def who_made_you
  puts "I was created by a team of developers."
end

def what_is_your_name
  puts "My name is Digital Assistant."
end

def computational_geographical_question
  puts "Please ask your question:"
  question = gets.chomp
  puts "Sorry, I'm unable to answer computational or geographical questions at the moment."
end

puts "Sk. Salahuddin - Khulna"

loop do
  puts "How may I assist you?"
  user_command = gets.chomp.downcase

  break if user_command.include?("exit") || user_command.include?("close") || user_command.include?("off") ||
           user_command.include?("good bye") || user_command.include?("bye") || user_command.include?("ok bye") ||
           user_command.include?("turn off") || user_command.include?("shutdown") || user_command.include?("no thanks") ||
           user_command.include?("stop")

  puts "Please wait"
  perform_action(user_command)
end
