require 'Qt'
require 'QtWebKitWidgets'

class MyWebBrowser < Qt::Widget
  def initialize
    super
    
    @window = Qt::Widget.new
    @window.window_title = 'Sk. Salahuddin - Morning 01 Batch'
    
    @layout = Qt::VBoxLayout.new(@window)
    
    @horizontal = Qt::HBoxLayout.new
    
    @search_bar = Qt::LineEdit.new
    @search_bar.placeholder_text = 'Search Google'
    @search_bar.minimum_height = 50
    @search_bar.style_sheet = <<-CSS
      QLineEdit {
        border: 2px solid #4a4a4a;
        border-radius: 25px;
        padding-left: 15px;
        padding-right: 50px;
        font-size: 18px;
        font-family: Arial;
      }
      QLineEdit:focus {
        border: 2px solid #0080ff;
      }
    CSS
    
    @go_btn = Qt::PushButton.new('GO')
    @go_btn.icon = Qt::Icon.new('go.png')
    @go_btn.icon_size = Qt::Size.new(32, 32)
    @go_btn.minimum_height = 50
    @go_btn.set_fixed_size(50, 50)
    @go_btn.style_sheet = <<-CSS
      QPushButton {
        border: none;
        background-color: #0080ff;
        border-radius: 25px;
      }
      QPushButton:hover {
        background-color: #005ce6;
      }
      QPushButton:pressed {
        background-color: #0047b3;
      }
    CSS
    
    @back_btn = Qt::PushButton.new('<')
    @back_btn.icon = Qt::Icon.new('back.png')
    @back_btn.icon_size = Qt::Size.new(32, 32)
    @back_btn.minimum_height = 50
    @back_btn.set_fixed_size(50, 50)
    @back_btn.style_sheet = <<-CSS
      QPushButton {
        border: none;
        background-color: #4a4a4a;
        border-radius: 25px;
      }
      QPushButton:hover {
        background-color: #333333;
      }
      QPushButton:pressed {
        background-color: #1a1a1a;
      }
    CSS
    
    @forward_btn = Qt::PushButton.new('>')
    @forward_btn.icon = Qt::Icon.new('forward.png')
    @forward_btn.icon_size = Qt::Size.new(32, 32)
    @forward_btn.minimum_height = 50
    @forward_btn.set_fixed_size(50, 50)
    @forward_btn.style_sheet = <<-CSS
      QPushButton {
        border: none;
        background-color: #4a4a4a;
        border-radius: 25px;
      }
      QPushButton:hover {
        background-color: #333333;
      }
      QPushButton:pressed {
        background-color: #1a1a1a;
      }
    CSS
    
    @horizontal.add_widget(@search_bar)
    @horizontal.add_widget(@go_btn)
    @horizontal.add_widget(@back_btn)
    @horizontal.add_widget(@forward_btn)
    
    @browser = QtWebKitWidgets::QWebEngineView.new
    @go_btn.connect(SIGNAL :clicked) { navigate(@search_bar.text) }
    @back_btn.connect(SIGNAL :clicked) { @browser.back }
    @forward_btn.connect(SIGNAL :clicked) { @browser.forward }
    @search_bar.return_pressed { navigate(@search_bar.text) }
    
    @layout.add_layout(@horizontal)
    @layout.add_widget(@browser)
    
    @browser.load(Qt::Url.new('https://www.google.com/'))
    
    @window.set_layout(@layout)
    @window.show
  end

  def navigate(url)
    if !url.start_with?('http')
      url = "https://www.google.com/search?q=#{url}"
      @search_bar.text = url
    end
    @browser.load(Qt::Url.new(url))
  end
end

app = Qt::Application.new(ARGV)
window = MyWebBrowser.new
app.exec
