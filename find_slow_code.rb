require 'benchmark'

def api_call
  sleep(2)
  nil
end

def process_data
  (10**7).times do
    # Do something
  end
end

def sort_data
  (10**8).times do
    # Do something
  end

  process_data
end

def reload_page
  process_data
  sort_data
  sleep(2)
end

def main
  api_call
  sort_data
  reload_page
end

puts "Timing program..."

Benchmark.bm do |bm|
  bm.report do
    main
  end
end
