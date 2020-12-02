file = File.open("input.txt")
file_data = file.readlines.map(&:chomp)
file.close

num_valid = 0
file_data.each do |line|
	tuple = line.split(' ')
	min = tuple[0].split('-')[0].to_i
	max = tuple[0].split('-')[1].to_i
	letter = tuple[1].split(':')[0]
	count = tuple[2].scan(/(?=#{letter})/).count
	num_valid += 1 if min <= count && count <= max
end
puts num_valid