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

def parse_seat_data input 
	data = convert_to_binary_rep input

	data.to_i(base=2)
end

file_data = read_input_data
ids = []
file_data.each do |line|
	ids << parse_seat_data(line)
end

puts "lowest seat id: #{ids.min}"
puts "highest seat id: #{ids.max}"

result = nil
# these magic numbers came fro the min / max above
(40...981).each do |i|
	if !ids.include? i
		result = i
	end
end

puts "your seat: #{result}"