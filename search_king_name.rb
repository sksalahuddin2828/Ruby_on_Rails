countries = {
  "Afghanistan" => "Taliban",
  "Australia" => "Scott Morrison",
  "Bangladesh" => "Sheikh Hasina",
  "Bhutan" => "Lotay Tshering",
  "Canada" => "Justin Trudeau",
  "Cambodia" => "Hun Sen",
  "China" => "Xi Jinping",
  "Denmark" => "Mette Frederiksen",
  "France" => "Emmanuel Macron",
  "Germany" => "Frank-Walter Steinmeier",
  "Japan" => "Fumio Kishida",
  "Laos" => "Thongloun Sisoulith",
  "Finland" => "Sanna Marin",
  "India" => "Narendra Modi",
  "Indonesia" => "Joko Widodo",
  "Malaysia" => "Gloria Macapagal-Arroyo",
  "Nepal" => "Ram Chandra Poudel",
  "New Zealand" => "Jacinda Ardern",
  "North Korea" => "Kim Jong-Un",
  "Norway" => "Jonas Gahr Støre",
  "Philippines" => "Bongbong Marcos",
  "Spain" => "Pedro Sánchez",
  "Singapore" => "Halimah Yacob",
  "South Korea" => "Yoon Suk-Yeol",
  "South Africa" => "Cyril Ramaphosa",
  "Sweden" => "Ulf Kristersson",
  "Switzerland" => "Alain Berset",
  "United Kingdom" => "Rishi Sunak",
  "United States" => "Joe Biden",
  "Vietnam" => "Vo Van Thuong",
  "Zambia" => "Hakainde Hichilema",
  "Zimbabwe" => "Emmerson Mnangagwa"
}

puts "Enter a country name: "
search_term = gets.chomp

matching_king = nil
countries.each do |country, king|
  if country.downcase == search_term.downcase
    matching_king = king
    break
  end
end

if matching_king
  puts "The King of #{search_term} is #{matching_king}."
else
  puts "No King found for #{search_term}."
end
