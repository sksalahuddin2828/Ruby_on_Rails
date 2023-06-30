require 'opencv'

cap = OpenCV::CvCapture.open(0)

def make_1080p(capture)
  capture.set(3, 1920)
  capture.set(4, 1080)
end

def make_720p(capture)
  capture.set(3, 1020)
  capture.set(4, 720)
end

def make_480p(capture)
  capture.set(3, 640)
  capture.set(4, 480)
end

def change_res(capture, width, height)
  capture.set(3, width)
  capture.set(4, height)
end

def rescale_frame(frame, percent = 75)
  scale_percent = percent
  width = (frame.width * scale_percent) / 100
  height = (frame.height * scale_percent) / 100
  dim = OpenCV::CvSize.new(width, height)
  return frame.resize(dim)
end

while true
  # Capture frame by frame
  frame = cap.query
  frame = rescale_frame(frame, 30)

  # Display the resulting frame
  OpenCV::GUI::Window.new('frame').show(frame)

  # Display the resulting frame 2
  frame2 = rescale_frame(frame, 500)
  OpenCV::GUI::Window.new('frame2').show(frame2)

  break if OpenCV::GUI::wait_key(20) & 0xFF == 'q'.ord
end

# When everything is done, release the capture
cap.release
OpenCV::GUI::destroy_window('frame')
OpenCV::GUI::destroy_window('frame2')
