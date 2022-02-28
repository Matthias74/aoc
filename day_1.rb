data = File.open('day_1_1.txt').readlines.map(&:chomp)
result = data.map(&:to_i)
puts "Result day 1-1: #{result.sum}"

data = data.map(&:to_i)
current = 0
sum_results = [current]

while true
	data.each do |number|
		current += number
		if sum_results.include?(current)
			puts "Result 1-2: #{current}"
			exit
		end

		sum_results << current
	end
end

#77674