require 'win32/sound'
include Win32

# Function to select a file
def select_file
  dialog = Sound::DlgOpen.new
  dialog.filter = 'Audio Files\0*.mp3;*.wav;*.ogg\0'
  dialog.title = 'Select an audio file'
  if dialog.show
    dialog.filename
  else
    ''
  end
end

# Function to play the selected file
def play_music(file_path)
  Sound.play(file_path, Sound::ASYNC)
end

# Function to stop the music
def stop_music
  Sound.stop
end

file_path = select_file
if !file_path.empty?
  play_music(file_path)
end

loop do
  puts '1. Select a file'
  puts '2. Stop music'
  puts '3. Exit'
  print 'Enter your choice: '

  choice = gets.chomp

  case choice
  when '1'
    file_path = select_file
    if !file_path.empty?
      play_music(file_path)
    end
  when '2'
    stop_music
  when '3'
    break
  end
end
