# gem install win32-sapi5
# gem install json

require 'win32/sapi5'
require 'net/http'
require 'json'

def speak(text)
  voice = WIN32OLE.new('SAPI.SpVoice')
  voice.speak(text)
end

def initialize_voice
  WIN32OLE.new('SAPI.SpVoice')
end

def take_command
  recognizer = WIN32OLE.new('SAPI.SpSharedRecognizer')
  audio = WIN32OLE.new('SAPI.SpMMAudioIn')
  stream = WIN32OLE.new('SAPI.SpStream')

  recognizer.AudioInput = audio
  recognizer.Recognizer = WIN32OLE.new('SAPI.SpInProcRecognizer')

  recognizer.RecognizeStream(stream)
  recognizer.WaitUntilDone(10_000)

  phrase = recognizer.GetSpPhraseFromStream(stream)

  user_input_text = phrase.PhraseInfo.GetText
  user_input_text.encode('UTF-8', 'UTF-16LE', invalid: :replace, undef: :replace, replace: '')

  user_input_text
end

def get_current_date_time
  Time.now.strftime('%Y-%m-%d %H:%M:%S')
end

def get_weather_report(city)
  url = "https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=99e68c086c34059f58d3349bd4fb694c&units=metric"

  uri = URI(url)
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  if data['cod'] == 200
    temperature = data['main']['temp']
    humidity = data['main']['humidity']
    wind_speed = data['wind']['speed']

    puts "Temperature: #{temperature}°C"
    puts "Humidity: #{humidity}%"
    puts "Wind Speed: #{wind_speed}m/s"
  else
    puts "Error occurred while fetching weather data."
  end
end

initialize_voice

loop do
  user_input = take_command.downcase

  if user_input == 'exit'
    speak('Goodbye!')
    break
  elsif user_input == 'time'
    current_time = get_current_date_time
    speak("The current time is #{current_time}")
  elsif user_input.start_with?('weather')
    city = user_input[7..-1]
    get_weather_report(city)
  else
    speak('Sorry, I didn\'t understand that.')
  end
end
