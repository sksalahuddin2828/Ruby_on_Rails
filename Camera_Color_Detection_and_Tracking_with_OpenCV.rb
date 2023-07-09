require "opencv"

def empty_function(value)
  threshold1 = cv.get_trackbar_pos("Threshold1", "Parameters")
  threshold2 = cv.get_trackbar_pos("Threshold2", "Parameters")
  area = cv.get_trackbar_pos("Area", "Parameters")
  puts "Threshold1: #{threshold1}"
  puts "Threshold2: #{threshold2}"
  puts "Area: #{area}"
end

frame_width = 640
frame_height = 480

cap = OpenCV::CvCapture.open
cap.set_capture_property(OpenCV::CV_CAP_PROP_FRAME_WIDTH, frame_width)
cap.set_capture_property(OpenCV::CV_CAP_PROP_FRAME_HEIGHT, frame_height)

cv.named_window("HSV")
cv.resize_window("HSV", 640, 240)
cv.create_trackbar("HUE Min", "HSV", 0, 179, method(:empty_function))
cv.create_trackbar("HUE Max", "HSV", 179, 179, method(:empty_function))
cv.create_trackbar("SAT Min", "HSV", 0, 255, method(:empty_function))
cv.create_trackbar("SAT Max", "HSV", 255, 255, method(:empty_function))
cv.create_trackbar("VALUE Min", "HSV", 0, 255, method(:empty_function))
cv.create_trackbar("VALUE Max", "HSV", 255, 255, method(:empty_function))

while true
  frame = cap.query_frame
  break if frame.nil?

  img_hsv = frame.bgr2hsv

  h_min = cv.get_trackbar_pos("HUE Min", "HSV")
  h_max = cv.get_trackbar_pos("HUE Max", "HSV")
  s_min = cv.get_trackbar_pos("SAT Min", "HSV")
  s_max = cv.get_trackbar_pos("SAT Max", "HSV")
  v_min = cv.get_trackbar_pos("VALUE Min", "HSV")
  v_max = cv.get_trackbar_pos("VALUE Max", "HSV")

  lower = OpenCV::CvScalar.new(h_min, s_min, v_min)
  upper = OpenCV::CvScalar.new(h_max, s_max, v_max)

  mask = img_hsv.in_range(lower, upper)
  result = OpenCV::CvMat.new(frame.size, frame.depth, frame.channel)
  result.set(mask)

  mask = mask.cvt_color(OpenCV::CV_GRAY2BGR)
  h_stack = OpenCV::CvMat.hconcat([frame, mask, result])

  cv.imshow("Horizontal Stacking", h_stack)

  break if cv.wait_key(1) == "q"
end

cv.destroy_all_windows
