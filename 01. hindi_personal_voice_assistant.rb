require 'date'
require 'rubygems'
require 'google_translate'

def speak(text)
  `say #{text}`
end

def clockTime()
  hour = Time.now.hour
  if hour >= 0 && hour < 12
    speak("शुभ प्रभात")
  elsif hour >= 12 && hour < 18
    speak("अभी दोपहर")
  elsif hour >= 18 && hour < 20
    speak("अभी शाम")
  else
    speak("शुभ रात्रि")
  end
end

translator = Google::Translator.new

clockTime()
speak("हैलो मेरा नाम शेख सलाहुद्दीन है, बताइये में आपकी क्या मदद कर सक्ती हूं")

loop do
  speak("बोलिए और क्या मदद चाहिए")
  command = gets.chomp

  begin
    translated = translator.translate(command, from: 'hi', to: 'en')

    if translated.downcase.include?('time') || translated.downcase.include?('date') || translated.downcase.include?('time and date')
      current_time = Time.now.strftime('%I:%M %p')
      current_date = Date.today.strftime('%Y-%m-%d')
      speak("वर्तमान समय है #{current_time} और आज की तारीख है #{current_date}")
    elsif translated.downcase.include?('ip address')
      speak("अपने आईपी पते की जाँच कर रहे हैं, कृपया प्रतीक्षा करें!")
      ip_address = `curl ifconfig.me`
      speak("आपका आईपी पता है: #{ip_address}")
    elsif translated.downcase.include?('youtube')
      speak("Youtube खोला जा रहा है")
      `open https://www.youtube.com/`
    elsif translated.downcase.include?('google')
      speak("Google खोला जा रहा है")
      `open https://www.google.com/`
    elsif translated.downcase.include?('wikipedia')
      speak("Wikipedia खोला जा रहा है")
      `open https://en.wikipedia.org/`
    elsif translated.downcase.include?('who made you') || translated.downcase.include?('creator')
      speak("मेरे निर्माता का नाम है शेख सलाहुद्दीन। उनका ईमेल है sksalahuddin2828@gmail.com")
    elsif translated.downcase.include?('close') || translated.downcase.include?('exit') || translated.downcase.include?('good bye') || translated.downcase.include?('ok bye') || translated.downcase.include?('turn off') || translated.downcase.include?('shut down')
      speak("आपने कहा था, अलविदा! धन्यवाद")
      break
    else
      speak("मुझे वह समझ नहीं आया। कृपया फिर से कहें")
    end
  rescue Google::Translate::TranslateError => e
    speak("अनुवाद करने में त्रुटि हुई: #{e.message}")
  end
end
