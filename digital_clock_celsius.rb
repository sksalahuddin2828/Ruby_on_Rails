require 'qt'
require 'time'
require 'date'
require 'json'
require 'net/http'
require 'openssl'

class DigitalClock < Qt::Widget
  def initialize
    super

    setWindowTitle("Digital Clock")
    setStyleSheet("background-color: #272727;")

    @layout = Qt::VBoxLayout.new(self)
    setLayout(@layout)

    @date_label = Qt::Label.new
    @date_label.setAlignment(Qt::AlignCenter)
    @date_label.setStyleSheet("font-size: 60px; background-color: #272727; color: #ffffff;")
    @layout.addWidget(@date_label)

    @time_label = Qt::Label.new
    @time_label.setAlignment(Qt::AlignCenter)
    @time_label.setStyleSheet("font-size: 200px; background-color: #272727; color: #F39C12;")
    @layout.addWidget(@time_label)

    @temperature_label = Qt::Label.new
    @temperature_label.setAlignment(Qt::AlignCenter)
    @temperature_label.setStyleSheet("font-size: 45px; background-color: #272727; color: #ffffff;")
    @layout.addWidget(@temperature_label)

    @unit_button = Qt::PushButton.new("Switch to Fahrenheit")
    @unit_button.connect(SIGNAL('clicked()')) { toggle_units }
    @layout.addWidget(@unit_button)
    @unit_button.setStyleSheet("background-color: #3498DB; font-weight:bold; color: #ffffff;")

    gradient = "background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #3498DB, stop:1 #E74C3C);"
    setStyleSheet("QWidget { #{gradient} }")

    @units = "metric"
    toggle_units

    @timer = Qt::Timer.new
    connect(@timer, SIGNAL('timeout()'), self, SLOT('update_clock()'))
    @timer.start(1000)

    @time_animation = Qt::PropertyAnimation.new(@time_label, "geometry")
    @time_animation.setDuration(1000)
    @time_animation.setStartValue(Qt::Rect.new(0, 0, 0, @time_label.height()))
    @time_animation.setEndValue(Qt::Rect.new(0, 0, width(), @time_label.height()))
    @time_animation.start

    @date_animation = Qt::PropertyAnimation.new(@date_label, "geometry")
    @date_animation.setDuration(1000)
    @date_animation.setStartValue(Qt::Rect.new(0, @time_label.height(), 0, @date_label.height()))
    @date_animation.setEndValue(Qt::Rect.new(0, @time_label.height(), width(), @date_label.height()))
    @date_animation.start

    @temperature_animation = Qt::PropertyAnimation.new(@temperature_label, "geometry")
    @temperature_animation.setDuration(1000)
    @temperature_animation.setStartValue(Qt::Rect.new(0, @time_label.height() + @date_label.height(), 0, @temperature_label.height()))
    @temperature_animation.setEndValue(Qt::Rect.new(0, @time_label.height() + @date_label.height(), width(), @temperature_label.height()))
    @temperature_animation.start
  end

  def get_temperature
    api_key = "API KEY"
    city = "Khulna"
    url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{api_key}&units=#{@units}"
    uri = URI(url)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    data = JSON.parse(response.body)
    temperature = data["main"]["temp"]

    temperature
  end

  def update_clock
    now = Time.now
    date = now.strftime("%A, %B %d, %Y")
    time = now.strftime("%I:%M:%S %p")
    temperature = get_temperature
    temperature_celsius = "#{temperature.round(1)} °C"
    temperature_fahrenheit = "#{(temperature * 9 / 5 + 32).round(1)} °F"
    temperature_str = "#{temperature_celsius} / #{temperature_fahrenheit}"
    
    @date_label.text = date
    @time_label.text = time
    @temperature_label.text = temperature_str
  end

  def toggle_units
    if @units == "metric"
      @units = "imperial"
      @unit_button.text = "Switch to Celsius"
    else
      @units = "metric"
      @unit_button.text = "Switch to Fahrenheit"
    end
  end
end

app = Qt::Application.new(ARGV)
window = DigitalClock.new
window.show
app.exec
