data_input = "day_8_data.txt"
data_input_test = "day_8_data_test.txt"

data = File.readlines(data_input_test, chomp: true)[0]

# def day_1(data)
#   metadatas = []
#   nodes = [data]
  
#   while nodes.length > 0 do
#     node_to_a = nodes.first.split(" ")
#     puts "ici: #{node_to_a}"
#     nodes_number, metadatas_number = node_to_a.first(2).map(&:to_i)
#     break if node_to_a.length < metadatas_number
#     metadatas << node_to_a.last(metadatas_number)
#     node_to_a.shift(2)
#     node_to_a.pop(metadatas_number)
#     if nodes_number > 0 && (node_to_a.length / nodes_number) > 0
#       puts "#{node_to_a} #{node_to_a.length} / #{nodes_number}"
#       scliced = node_to_a.each_slice(node_to_a.length / nodes_number).to_a
#       if node_to_a.length % nodes_number != 0
#         last = scliced.pop
#         last.each { |number| scliced.last.push(number) }
#       end
#       scliced.each { |node| nodes << node.join(" ")}
#     end
#     nodes = nodes.filter { |node| node != nodes.first }
#   end

#   puts metadatas.flatten.map(&:to_i).sum
# end

# day_1(data

# 2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2
# A----------------------------------
#     B----------- C-----------
#                      D-----

def sum(numbers)
  puts "numbers: #{numbers}"

  child_nodes = numbers.shift
  meta_entries = numbers.shift

  puts "start: #{numbers} - #{child_nodes} - #{meta_entries}"

  sum = 0

  child_nodes.times do
    puts "ici"
    sum += sum(numbers)
  end

  puts "end: #{numbers} - #{child_nodes} - #{meta_entries}"
  
  meta_entries.times do
    sum += numbers.shift
  end

  sum
end

puts sum([2, 3, 0, 3, 10, 11, 12, 1, 1, 0, 1, 99, 2, 1, 1, 2])


#1
# numbers = 2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2
# child_nodes = 2
# meta_entries = 3
# sum = ?
# numbers = 0 3 10 11 12 1 1 0 1 99 2 1 1 2

#2 
# numbers = 0 3 10 11 12 1 1 0 1 99 2 1 1 2
# child_nodes = 0
# meta_entries = 3
# sum = ?
# numbers = 0 3 10 11 12 1 1 0 1 99 2 1 1 2


#2'
# numbers = 0 3 10 11 12 1 1 0 1 99 2 1 1 2
# child_nodes = 0
# meta_entries = 3
# sum = ?
# numbers = 0 3 10 11 12 1 1 0 1 99 2 1 1 2


#3
# numbers = 0 3 10 11 12 1 1 0 1 99 2 1 1 2
# child_nodes = 0
# meta_entries = 3
# sum = ?
# numbers = 0 3 10 11 12 1 1 0 1 99 2 1 1 2









































# nodes = {}

  # [data].each_with_index do |line, line_index|
  #   nodes[line_index] = {}
  #   node_number = 1
  #   metadata_place = 1
  #   tree = line

  #   while true do
  #     nodes[line_index][node_number] = []
  #     break if tree.empty?
  #     header = tree.first(2)
  #     tree = tree.drop(2)
  #     child_nodes, metadata_entries = header

  #     starting_index_to_remove = metadata_place == 1 ? tree.length : -1

  #     indexes_to_remove = [].tap do |arr|
  #       (metadata_entries.to_i).times do
  #         arr << (metadata_place == 1 ? starting_index_to_remove -= 1 : starting_index_to_remove += 1)
  #       end
  #     end

  #     nodes[line_index][node_number] << [].tap do |arr|
  #       tree.each_with_index { |node, index| arr << node if indexes_to_remove.include?(index) }
  #     end

  #     tree = [].tap do |arr|
  #       tree.each_with_index { |node, index| arr << node unless indexes_to_remove.include?(index) }
  #     end

  #     metadata_place = metadata_place == 1 ? 0 : 1
  #     node_number += 1
  #   end
  # end
  # puts nodes
  # puts nodes.values.map { |node| node.values }.flatten.map(&:to_i).sum 