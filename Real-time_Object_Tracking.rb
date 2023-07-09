require 'opencv'

# Create a window to display the video
window = OpenCV::GUI::Window.new('Tracking')

# Create a capture object
capture = OpenCV::CvCapture.open
unless capture.is_opened
  puts 'Failed to open capture'
  exit
end

# Read the first frame from the video
frame = capture.query
unless frame
  puts 'Failed to read video'
  exit
end

# Select the region of interest (ROI) for tracking
bbox = OpenCV::GUI::select_ROI('Tracking', frame)

# Create a tracker object
tracker = OpenCV::CvTrackingKCF.new

# Initialize the tracker with the selected ROI
tracker.init(frame, bbox)

# Main loop for video processing
while true
  # Read a frame from the video
  frame = capture.query
  unless frame
    puts 'Failed to read video'
    break
  end

  # Update the tracker with the current frame
  success, bbox = tracker.update(frame)

  # If tracking is successful, draw the bounding box
  if success
    frame.rectangle!(bbox.top_left, bbox.bottom_right, color: OpenCV::CvColor::Yellow, thickness: 3)
    frame.put_text('Tracking', bbox.top_left, OpenCV::CvFont.new(:hershey_script_simplex), 0.9, color: OpenCV::CvColor::Yellow, thickness: 2)
  else
    # If tracking is lost, display "Lost" message
    frame.put_text('Lost', OpenCV::CvPoint.new(20, 40), OpenCV::CvFont.new(:hershey_script_simplex), 0.9, color: OpenCV::CvColor::Red, thickness: 2)
  end

  # Display the image with tracking results
  window.show(frame)

  # Exit the loop if 'q' is pressed
  break if OpenCV::GUI::wait_key(1) == 'q'
end

# Release the capture and close windows
capture.release
window.destroy
