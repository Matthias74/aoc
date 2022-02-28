data = File.readlines("day_1_data.txt", chomp: true).map(&:to_i)

count_first = []
data.each_with_index do |number, index|
  next if index == 0
  count_first << number if number > data[index - 1]
end

puts count_first.length

# count = -1
# prev_line = 0

# count_bis = []
# File.read("day_1_data.txt").split("\n").map(&:to_i).each do |line|
#   count_bis << line if line > prev_line

#   prev_line = line
# end

# puts "first: #{count_first}"
# puts "second : #{count_bis}"


