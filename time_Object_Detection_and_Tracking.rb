require 'opencv'

def empty_function(value)
  threshold1 = OpenCV::GUI::Trackbar.get_pos('Threshold1', 'Parameters')
  threshold2 = OpenCV::GUI::Trackbar.get_pos('Threshold2', 'Parameters')
  area = OpenCV::GUI::Trackbar.get_pos('Area', 'Parameters')
  puts "Threshold1: #{threshold1}"
  puts "Threshold2: #{threshold2}"
  puts "Area: #{area}"
end

frame_width = 640
frame_height = 480

cap = OpenCV::CvCapture.open
cap.set(OpenCV::CV_CAP_PROP_FRAME_WIDTH, frame_width)
cap.set(OpenCV::CV_CAP_PROP_FRAME_HEIGHT, frame_height)

OpenCV::GUI::Window.new('Parameters') do
  OpenCV::GUI::Trackbar.create('Threshold1', 'Parameters', 23, 255, &method(:empty_function))
  OpenCV::GUI::Trackbar.create('Threshold2', 'Parameters', 20, 255, &method(:empty_function))
  OpenCV::GUI::Trackbar.create('Area', 'Parameters', 5000, 30000, &method(:empty_function))

  while OpenCV::GUI::Window.active?('Parameters')
    img = cap.query
    break if img.empty?

    img_contour = img.clone
    img_blur = img.smooth_open(cv: OpenCV::CV_GAUSSIAN, size: OpenCV::CvSize.new(7, 7), sigma1: 1)
    img_gray = img_blur.BGR2GRAY
    threshold1 = OpenCV::GUI::Trackbar.get_pos('Threshold1', 'Parameters')
    threshold2 = OpenCV::GUI::Trackbar.get_pos('Threshold2', 'Parameters')
    img_canny = img_gray.canny(threshold1, threshold2)
    kernel = OpenCV::IplConvKernel.new(5, 5, 2, 2, OpenCV::IPL_CROSS)
    img_dil = img_canny.dilate(kernel)
    get_contours(img_dil, img_contour)
    img_stack = OpenCV::GUI::Window.hconcat([[img, img_canny], [img_dil, img_contour]])

    img_stack.show('Result')
    key = OpenCV::GUI::wait_key(1)
    break if key == 'q'
  end
end

def get_contours(img, img_contour)
  contours = img.find_contours(
    mode: OpenCV::CV_RETR_EXTERNAL,
    method: OpenCV::CV_CHAIN_APPROX_NONE
  )
  area_min = OpenCV::GUI::Trackbar.get_pos('Area', 'Parameters')

  contours.each do |contour|
    area = contour.contour_area
    next unless area > area_min

    img_contour.draw_contours!(contour, OpenCV::CvColor::MAGENTA, 7)

    perimeter = contour.arc_length(true)
    approx = contour.approx_polygon(0.02 * perimeter, true)
    rect = approx.bounding_rect
    img_contour.rectangle!(rect.top_left, rect.bottom_right, OpenCV::CvColor::GREEN, thickness: 5)
    img_contour.put_text!("Points: #{approx.size}", OpenCV::CvPoint.new(rect.right + 20, rect.top + 20),
                          OpenCV::GUI::FONT_HERSHEY_COMPLEX, 0.7, OpenCV::CvColor::GREEN, thickness: 2)
    img_contour.put_text!("Area: #{area.to_i}", OpenCV::CvPoint.new(rect.right + 20, rect.top + 45),
                          OpenCV::GUI::FONT_HERSHEY_COMPLEX, 0.7, OpenCV::CvColor::GREEN, thickness: 2)
  end
end
