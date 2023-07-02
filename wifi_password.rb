class WifiProfile
  attr_accessor :ssid, :password

  def initialize(ssid, password)
    @ssid = ssid
    @password = password
  end

  def to_s
    "SSID: #{@ssid}, Password: #{@password}"
  end
end

def get_wifi_profiles
  wifi_list = []
  
  command = "netsh wlan show profiles"
  command_output = `#{command}`
  
  profiles = command_output.scan(/    All User Profile\s+: (.*)\r/).flatten
  
  profiles.each do |profile|
    profile_command = "netsh wlan show profile \"#{profile}\" key=clear"
    profile_output = `#{profile_command}`
    
    if !profile_output.include?("Security key           : Absent")
      password = profile_output[/Key Content\s+: (.*)\r/, 1]
      wifi_list << WifiProfile.new(profile, password)
    end
  end
  
  wifi_list
end

wifi_list = get_wifi_profiles

wifi_list.each do |wifi_profile|
  puts wifi_profile
end
