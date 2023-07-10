MERCURY_GRAVITY = 0.376
VENUS_GRAVITY = 0.889
MARS_GRAVITY = 0.378
JUPITER_GRAVITY = 2.36
SATURN_GRAVITY = 1.081
URANUS_GRAVITY = 0.815
NEPTUNE_GRAVITY = 1.14

def calculate_planet_weight(earth_weight, planet)
  case planet
  when "Mercury"
    earth_weight * MERCURY_GRAVITY
  when "Venus"
    earth_weight * VENUS_GRAVITY
  when "Mars"
    earth_weight * MARS_GRAVITY
  when "Jupiter"
    earth_weight * JUPITER_GRAVITY
  when "Saturn"
    earth_weight * SATURN_GRAVITY
  when "Uranus"
    earth_weight * URANUS_GRAVITY
  when "Neptune"
    earth_weight * NEPTUNE_GRAVITY
  else
    0
  end
end

def main
  print "Enter a weight on Earth: "
  earth_weight = gets.chomp.to_f

  print "Enter a planet: "
  planet = gets.chomp.capitalize

  until ["Mercury", "Venus", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"].include?(planet)
    if planet == "Earth"
      puts "Please select a planet other than Earth."
    else
      puts "Error: #{planet} is not a planet."
    end

    print "Enter a planet: "
    planet = gets.chomp.capitalize
  end

  planet_weight = calculate_planet_weight(earth_weight, planet)
  planet_weight_rounded = planet_weight.round(2)

  puts "The equivalent weight on #{planet}: #{planet_weight_rounded}"
end

main
