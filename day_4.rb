data_input = 'day_4_1.txt'
data_test_input = 'day_4_1_test.txt'

data = File.open(data_input).readlines.map(&:chomp).sort do |a, b|
	a.match(/\[.*\]/)[0].gsub(/\[|\]/, "") <=> b.match(/\[.*\]/)[0].gsub(/\[|\]/, "")
end

gards_activity = {}
gard_number = nil
start_sleep_time = nil
wake_up_time = nil

data.each do |activity|
	if gard_number_match = activity.match(/\#[0-9]+/)
		gard_number = gard_number_match[0]
		gards_activity[gard_number] = {} unless gards_activity[gard_number]
	end
	time = activity.match(/\[.*\]/)[0].gsub(/\[|\]/, "").split(" ").last
	next if activity.include?("Guard")
	start_sleep_time = time if activity.include?("falls asleep")
	wake_up_time = time if activity.include?("wakes up")
	next unless wake_up_time
	(start_sleep_time.split(":").last.to_i...wake_up_time.split(":").last.to_i).each do |number|
		 gards_activity[gard_number][number] ? gards_activity[gard_number][number] += 1 : gards_activity[gard_number][number] = 1
	end
	start_sleep_time = nil
	wake_up_time = nil
end

most_sleeping_gard = gards_activity.sort_by do |key, value|
	gards_activity[key].values.sum
end.last

most_sleeping_gard[1].delete(:total_minutes)

most_sleeping_minute = most_sleeping_gard[1].invert[most_sleeping_gard[1].invert.keys.max]

puts "PART 1"
puts "Result: #{most_sleeping_gard[0].gsub("#", "").to_i * most_sleeping_minute}"

puts "PART 2"

max_minute_asleep = gards_activity.values.map { |value| value.values }.flatten.max

gard_id = nil
minute_asleep = nil

gards_activity.each do |key, value|
	values = []
	value.each { |k, v| values << [k, v] }
	matched = values.find { |v| v[1] == max_minute_asleep }
	if matched
		gard_id = key
		minute_asleep = matched[0]
		break
	end
end

puts "Result: #{gard_id.gsub("#", "").to_i * minute_asleep}"