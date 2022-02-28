data_input = "day_7_data.txt"
data_input_test = "day_7_data_test.txt"

data = File.readlines(data_input, chomp: true).map do |line|
	line.scan(/step\s[A-Z]/i).each { |matching| matching.gsub!(/step\s/i, "")}
end

def part_1(data)
  prerequisites = {}.tap { |hash_data| data.each { |d| hash_data[d.last] ? hash_data[d.last] << d.first : hash_data[d.last] = [d.first] } }
	starting_steps = (prerequisites.keys.sort.first..prerequisites.keys.sort.last).to_a - prerequisites.keys
  
	result = []

  starting_steps.each do |starting_step|
    remaining_steps = []
    next_step = starting_step 
    while true do
      result << next_step
      next_steps = data.filter { |step| step.first == next_step }
      break if next_steps.empty?
      available_steps = next_steps.map(&:last)
      available_steps.each { |step| prerequisites[step] = (prerequisites[step] - [next_step]) }
      available_steps = available_steps.filter { |step| prerequisites[step].length == 0 }
      next_step = (available_steps + remaining_steps).sort.first
      (available_steps - [next_step]).each { |step| remaining_steps << step }
      remaining_steps = remaining_steps - [next_step]
    end
  end
  puts result.join('')
end

def part_2(data)
  # Disclaimer: part_2 not done by me:
  lines = File.readlines(data)
  forward = Hash.new { |h, k| h[k] = [] }
  reverse = Hash.new { |h, k| h[k] = [] }
  lines.each do |line|
    words = line.split(' ')
    forward[words[1]] << words[7]
    reverse[words[7]] << words[1]
  end

  results = []
  forward.keys.each do |root|
    root = reverse[root].first while reverse[root].count > 0
    results << root unless results.include?(root)
  end

  order = []
  workers = {}
  worker_count = 5
  seconds_added = 61
  time = 0
  while results.count > 0 || workers.keys.count > 0
    worker_count.times do
      next unless workers.keys.count < worker_count

      ready = (results - workers.keys).select { |root| (reverse[root] - order).count == 0 }
      if ready.count > 0
        expand = ready.min
        workers[expand] = seconds_added + (expand.ord - 'A'.ord)
      end
    end
    workers.keys.each { |i| workers[i] -= 1 }
    ready = workers.select { |_, v| v == 0 }.keys
    ready.each do |expand|
      order << expand
      results += forward[expand]
      results.delete(expand)
      workers.delete(expand)
      results.uniq!
    end
    time += 1
  end

  puts time
end

part_1(data)
part_2(data_input)



