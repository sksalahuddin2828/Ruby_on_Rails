# Please note that this code uses the ruby-opencv gem, so make sure to install it before running the code.
# You can install it by executing gem install ruby-opencv.
# Also, the equivalent Ruby code assumes that you have the OpenCV library installed on your system.

require 'opencv'

filename = 'video.avi'    # change here which format you want to save here .mp4 .avi etc
frames_per_second = 24.0
res = '720p'

# Set resolution for the video capture
def change_res(capture, width, height)
  capture.set(3, width)
  capture.set(4, height)
end

# Standard Video Dimensions Sizes
STD_DIMENSIONS = {
  '480p' => [640, 480],
  '720p' => [1280, 720],
  '1080p' => [1920, 1080],
  '4k' => [3840, 2160]
}

# Grab resolution dimensions and set video capture to it.
def get_dims(capture, res = '1080p')
  width, height = STD_DIMENSIONS['480p']
  if STD_DIMENSIONS.key?(res)
    width, height = STD_DIMENSIONS[res]
  end
  # Change the current capture device to the resulting resolution
  change_res(capture, width, height)
  return width, height
end

# Video Encoding, might require additional installs
# Types of Codes: http://www.fourcc.org/codecs.php
VIDEO_TYPE = {
  'avi' => 'XVID',
  'mp4' => 'XVID'
}

def get_video_type(filename)
  _, ext = File.extname(filename)
  ext = ext[1..-1] if ext.start_with?('.')
  if VIDEO_TYPE.key?(ext)
    return VIDEO_TYPE[ext].unpack('C*').pack('L*').to_i
  end
  return VIDEO_TYPE['avi'].unpack('C*').pack('L*').to_i
end

capture = OpenCV::CvCapture.open
output = OpenCV::CvVideoWriter.open(filename, get_video_type(filename), frames_per_second, get_dims(capture, res))

while true
  frame = capture.query
  output.write(frame)
  OpenCV::GUI::Window.new('frame').show(frame)
  break if OpenCV::GUI::wait_key(1) & 0xFF == 'q'.ord
end

capture.release
output.release
OpenCV::GUI::destroy_window('frame')
