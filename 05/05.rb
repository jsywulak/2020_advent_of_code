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
	result[:sid] = result[:row] * 8 + result[:col]
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
file_data.each do |line|
	seat = parse_seat_data line
	seats << seat
end

seats_per_row = {}

seats.each do |seat|
  if seats_per_row[seat[:row]].nil?
  	seats_per_row[seat[:row]] = 0
  end
  seats_per_row[seat[:row]] += 1
end

seats_per_row.each do |row, seats|
	if seats != 8
		puts "#{row} is missing a seat"
	end
end

seats.each do |seat|
	if seat[:row] == 75
		puts seat[:col]
	end
end

puts seats_per_row

puts 75 * 8 + 7
