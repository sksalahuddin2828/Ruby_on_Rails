require 'Qt'
require 'httparty'

class WeatherApp < Qt::Widget
  def initialize
    super
    
    self.window_title = 'Sk. Salahuddin Morning 01 Batch'
    self.fixed_size = Qt::Size.new(520, 270)
    
    @layout = Qt::VBoxLayout.new(self)
    @title_label = Qt::Label.new('Weather App', self)
    @title_label.alignment = Qt::AlignCenter
    @title_label.font = Qt::Font.new('Arial', 18, Qt::Font::Bold)
    @layout.add_widget(@title_label)

    @input_layout = Qt::HBoxLayout.new
    @input_label = Qt::Label.new('Enter City Name:', self)
    @input_label.font = Qt::Font.new('Arial', 12)
    @input_edit = Qt::LineEdit.new(self)
    @input_edit.font = Qt::Font.new('Arial', 12)
    @input_layout.add_widget(@input_label)
    @input_layout.add_widget(@input_edit)
    @layout.add_layout(@input_layout)

    @submit_button = Qt::PushButton.new('Submit', self)
    @submit_button.font = Qt::Font.new('Arial', 12)
    @submit_button.connect(SIGNAL :clicked) { update_weather }
    @layout.add_widget(@submit_button)

    @weather_layout = Qt::VBoxLayout.new
    @temperature_label = Qt::Label.new(self)
    @temperature_label.alignment = Qt::AlignCenter
    @temperature_label.font = Qt::Font.new('Arial', 14)
    @weather_layout.add_widget(@temperature_label)
    @description_label = Qt::Label.new(self)
    @description_label.alignment = Qt::AlignCenter
    @description_label.font = Qt::Font.new('Arial', 14)
    @weather_layout.add_widget(@description_label)
    @layout.add_layout(@weather_layout)
  end

  def update_weather
    city = @input_edit.text
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{ENV['OPENWEATHERMAP_API_KEY']}&units=metric"
    response = HTTParty.get(url)
    data = JSON.parse(response.body)

    if data['main'].nil?
      @temperature_label.text = 'City not found'
      @description_label.text = ''
    else
      temp = data['main']['temp']
      description = data['weather'][0]['description']
      @temperature_label.text = "Temperature: #{temp} °C"
      @description_label.text = "Description: #{description.capitalize}"
    end
  end
end

app = Qt::Application.new(ARGV)
weather_app = WeatherApp.new
weather_app.show
app.exec
