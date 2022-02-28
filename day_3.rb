data_test = [
	"#1 @ 1,3: 4x4",
	"#2 @ 3,1: 4x4",
	"#3 @ 5,5: 2x2"
]

datas = File.open('day_3_data.txt').readlines.map(&:chomp)

positions = {}
claims_points = {}

1000.times do |num|
	1000.times do |n|
		positions["#{num}-#{n}"] = nil
	end
end

def fill_overlaps(datas, positions, claims_points)
	datas.each do |data|
		claim, _, raw_point, size = data.split(" ")
		raw_point = raw_point.gsub(":", "").split(",").map(&:to_i)
		size = size.split("x").map(&:to_i)

		size[0].times do |vertical|
			size[1].times do |horizontal|
				vertical_point = (raw_point[0] + vertical)
				horizontal_point = (raw_point[1] + horizontal)
				key = "#{vertical_point}-#{horizontal_point}"
				fill_claim_points(claims_points, claim, key)
				if positions[key].nil?
					positions[key] = "0"
				elsif positions[key] == "0"
					positions[key] = "X"
				end
			end
		end
	end
end

def fill_claim_points(claims_points, claim, value)
	if claims_points[claim]
		claims_points[claim] << value
	else
		claims_points[claim] = [value]
	end
end

fill_overlaps(datas, positions, claims_points)


# Part_1
puts "Part 1"
print positions.values.filter { |value| value == "X" }.count

#Part 2
puts "Part 2"
claims_points.keys.find do |claim_id|
	overlap_count = 0
	claims_points[claim_id].each do |point|
		overlap_count += 1 if positions[point] == "X"
	end

	if overlap_count == 0
		print claim_id
		break
	end
end
# expected output => 4