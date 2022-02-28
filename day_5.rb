data_input = 'day_5_data.txt'
data_test_input = 'day_5_data_test.txt'

data = File.readlines(data_input, chomp: true)[0]

# def part_1_slow(polymer)
# 	indexes_to_remove = []
# 	splited_polymer = polymer.split("")
# 	splited_polymer.each_with_index do |letter, index|
# 		has_matching = false
# 		next_letter = splited_polymer[index + 1]
# 		break unless next_letter
# 		if !!letter.match(/[A-Z]/)
# 			has_matching = true if letter.downcase == next_letter
# 		else
# 			has_matching = true if !!next_letter.match(/[A-Z]/) && letter == next_letter.downcase
# 		end
# 		indexes_to_remove << [index, index + 1] if has_matching && indexes_to_remove.last&.last != index
# 	end
# 	return polymer.length if indexes_to_remove.length == 0
# 	new_polymer = []
# 	splited_polymer.each_with_index do |l, i|
# 		new_polymer << l unless indexes_to_remove.flatten.include?(i)
# 	end
# 	part_1(new_polymer.join(""))
# end

# # puts part_1_slow(data)

def part_1_fast(polymer)
  input     = polymer

  loop do
    prev_length = input.length

    input.gsub!(/([A-z])\1+/i) do |match|
      chr = match[0]
      pattern = chr.downcase + chr.upcase

      match
        .gsub(pattern, "")
        .gsub(pattern.reverse, "")
    end

    break if input.length == prev_length
  end

  input.length
end

puts "Part 2"

def part_2(polymer)
  cleaned_polymers = []
  polymer.split("").map(&:downcase).uniq.each do |letter|
    cleaned_polymers << polymer.gsub(/#{letter}/i, "")
  end

  minimal = nil
  cleaned_polymers.each do |cleaned|
    result = part_1_fast(cleaned)
    minimal = result unless minimal
    minimal = result if result < minimal 
  end

  puts minimal
end

part_2(data)

