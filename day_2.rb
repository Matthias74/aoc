real_data = data = File.open('day_2.txt').readlines.map(&:chomp)

# Part 1
data_test = %w(
	abcdef 
	bababc 
	abbcde 
	abcccd 
	aabcdd 
	abcdee
	ababab
)

doubles = 0
triples = 0

real_data.each do |data|
	occurences = data.split('').tally
	next unless occurences.values.find {|value| value > 1 }
	doubles += 1 if occurences.values.find { |value| value == 2 }
	triples += 1 if occurences.values.find { |value| value == 3 }
end

# puts doubles * triples

# Part 2
puts "Day 2-2"

test_data = %w(
 	abcde
	fghij
	klmno
	pqrst
	fguij
	axcye
	wvxyz
)

real_data.first.length.times do |column|
	counts = Hash.new(0)

	real_data.map do |box|
    	text_trucated = box[0...column] + box[(column + 1)..-1]
    	counts[text_trucated] += 1
  	end

  	counts = counts.invert

	if counts[2]
		puts counts[2]
	    break
	end
end


# print "matching_data:#{matching_data}"
# print "current_data: #{current_data}"
# common_letters = matching_data - (matching_data - current_data)
# puts common_letters.join
