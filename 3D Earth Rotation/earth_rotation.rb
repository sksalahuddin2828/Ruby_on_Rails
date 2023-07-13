# You'll need to install the rubycocoa gem. You can install it by running gem install rubycocoa in your terminal.

require 'rubycocoa'

class EarthRotationAnimation
  FRAME_WIDTH = 800
  FRAME_HEIGHT = 600
  ROTATION_INTERVAL = 20

  def initialize
    @window = NSWindow.alloc.initWithContentRect(
      NSMakeRect(0, 0, FRAME_WIDTH, FRAME_HEIGHT),
      styleMask: NSTitledWindowMask | NSClosableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false
    )
    @web_view = WebView.alloc.initWithFrame(
      NSMakeRect(0, 0, FRAME_WIDTH, FRAME_HEIGHT)
    )

    setup_web_view
    setup_window

    load_animation_html
  end

  def run
    @window.makeKeyAndOrderFront(nil)
    NSApp.run
  end

  private

  def setup_web_view
    @web_view.setAutoresizingMask(NSViewWidthSizable | NSViewHeightSizable)
    @web_view.setFrameLoadDelegate(self)
  end

  def setup_window
    @window.contentView.addSubview(@web_view)
    @window.center
    @window.title = '3D Earth Rotation'
    @window.setDelegate(self)
  end

  def load_animation_html
    path = NSBundle.mainBundle.pathForResource('animation', ofType: 'html')
    url = NSURL.fileURLWithPath(path)
    request = NSURLRequest.requestWithURL(url)
    @web_view.mainFrame.loadRequest(request)
  end

  def webView(webView, didFinishLoadForFrame: frame)
    rotate_earth
  end

  def rotate_earth
    frame_count = 180
    frame_delay = ROTATION_INTERVAL

    script = <<~SCRIPT
      var frame = 0;
      function updateRotation() {
        var marker = document.getElementById('earth-marker');
        marker.style.transform = 'rotate(' + frame + 'deg)';
        frame += 2;
        if (frame > 360) {
          frame = 0;
        }
      }
      setInterval(updateRotation, #{frame_delay});
    SCRIPT

    @web_view.stringByEvaluatingJavaScriptFromString(script)
  end
end

app = NSApplication.sharedApplication
earth_rotation = EarthRotationAnimation.new
earth_rotation.run
app.setDelegate(nil)
