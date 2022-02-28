data_input = "day_6_data.txt"
data_input_test = "day_6_data_test.txt"

data = File.readlines(data_input, chomp: true).map do |line|
	line.gsub(" ", "").split(",").map(&:to_i)
end

def build_grid(data)
	current_letter_index = 0
	alphabet = ('A'..'Z').map { |letter| ('A'..'Z').map { |l| "#{letter}#{l}" } }.flatten

	grid = {}.tap do |grid_hash|
		grid_x_max = data.map(&:first).max + 2
		grid_y_max = data.map(&:last).max + 1
		(grid_y_max).times do |number|
			grid_x_max.times do |n| 
				grid_hash[[number ,n]] = nil
			end
		end
	end

	current_letter_index = 0
	data.each do |data|
		grid[data] = alphabet[current_letter_index]
		current_letter_index += 1
	end

	grid
end

def populate_with_distances(grid)
	cleaned_inverted_grid = grid.invert
	cleaned_inverted_grid.delete(nil)

	grid.each do |key, value|
		next if !value.nil?
		results = {}
		cleaned_inverted_grid.each do |letter, coordinates|
			x1, y1 = key
			x2, y2 = coordinates
			distance = (x1 - x2).abs + (y1 - y2).abs
			results[letter] = distance
		end
		min_distance = results.values.min
		if results.values.filter { |result_value| result_value == min_distance }.length > 1
				grid[key] = "."
		else
			grid[key] = results.invert[min_distance].downcase
		end
	end

	grid
end

def part_1(data)
	grid = populate_with_distances(build_grid(data))
	infinites_locations = []
	grid.keys.each do |coordinate|
		if [0, data.map(&:first).max + 1].include?(coordinate[0]) || [0, data.map(&:first).max].include?(coordinate[1])
			infinites_locations << coordinate
		end
	end

	infinite_areas_values = [].tap do |data|
		grid.each { |key, value| data << value.downcase if infinites_locations.include?(key) && value != "." }
	end.uniq

	{}.tap do |data|
		grid.each do |key, value|
			next if value == "." || infinite_areas_values.include?(value.downcase)
			data[value.downcase] ? data[value.downcase] += 1 : data[value.downcase] = 1
		end
	end.values.max
end

puts "Part 1: #{part_1(data)}"

def part_2(data)
	grid = build_grid(data)

	cleaned_inverted_grid = grid.invert
	cleaned_inverted_grid.delete(nil)

	points_total_dist_from_coordonates = []
	grid.each do |key, value|
		distances = 0
		cleaned_inverted_grid.each do |letter, coordinates|
			x1, y1 = key
			x2, y2 = coordinates
			distance = (x1 - x2).abs + (y1 - y2).abs
			distances += distance
		end
		points_total_dist_from_coordonates << key if distances < 10000
	end

	points_total_dist_from_coordonates.length
end

puts "Part 2: #{part_2(data)}"