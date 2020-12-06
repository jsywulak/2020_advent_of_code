def read_input_data
  file = File.open('input.txt')
  file_data = file.readlines.map(&:chomp)
  file.close

  file_data
end

def convert_to_binary_rep(input)
	input.gsub! 'B', '1'
	input.gsub! 'F', '0'
	input.gsub! 'R', '1'
	input.gsub! 'L', '0'
	input
end

def row input
	data = convert_to_binary_rep input
	data[0...7].to_i(base=2)
end

def col input
	data = convert_to_binary_rep input
	data[7...10].to_i(base=2)
end

def parse_seat_data input 
	result = {}
	result[:row] = row input
	result[:col] = col input
	result[:raw] = (convert_to_binary_rep input).to_i(base=2)
	result[:sid] = result[:row] * 8 + result[:col]
	puts result
	result
end

file_data = read_input_data
max = 0
file_data.each do |line|
	seat = parse_seat_data line
	if seat[:sid] > max
		max = seat[:sid]
	end
end

puts max

seats = []
ids = []
file_data.each do |line|
	seat = parse_seat_data line
	seats << seat
	ids << (seat[:sid] - 40)
end

sorted_ids = ids.sort
puts sorted_ids
0...sorted_ids.length do |i|
	if (sorted_ids.include? (i - 1)) && (sorted_ids.cd? (i + 1)) && (!sorted_ids.include? i)
		puts "okay it's this one: #{i}"
	end
end


# seat_map = Array.new(128, Array.new(8, false))
# seats.each do |seat|
# 	row = seat[:row]
# 	col = seat[:col]
# 	seat_map[row][col] = true
# 	puts "[#{seat_map}]"
# end

# puts "hello #{seat_map[75]}"
# seat_map.each do |row|
# 	if !row.empty?
# 		puts "#{row} is not full"
# 	end
# end
# puts "#{seat_map.length}"

# seat_map = Array.new(128, Array.new(8, false))
# seats.each do |seat|
# 	row = seat[:row]
# 	col = seat[:col]
# 	seat_map[row][col] = true
# end

# seat_map.each do |row|
# 	empty_seats = row.detect { |col| col == false}
# 	if !empty_seats.nil?
# 		puts "seat r:#{row} c:#{col} is empty"
# 	end
# end



# seat_map = {}
# seats.each do |seat|
# 	if seat_map[seat[:row]].nil?
# 		seat_map[seat[:row]] = [8]
# 	end
# 	seat_map[seat[:row]][seat[:col]] = "X"
# end

# seat_map.each do |row, seats|
# 	puts "#{row}, #{seats.flatten}"
# end

# seats_per_row = {}

# seats.each do |seat|
#   if seats_per_row[seat[:row]].nil?
#   	seats_per_row[seat[:row]] = 0
#   end
#   seats_per_row[seat[:row]] += 1
# end

# seats_per_row.each do |row, seats|
# 	if seats != 8
# 		puts "#{row} is missing a seat"
# 	end
# end

# seats.each do |seat|
# 	if seat[:row] == 75
# 		puts seat[:col]
# 	end
# end

# puts seats_per_row

# puts 75 * 8 + 7
