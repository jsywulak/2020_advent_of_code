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

num_valid = 0
file_data.each do |line|
	tuple = line.split(' ')
	pos1 = tuple[0].split('-')[0].to_i - 1
	pos2 = tuple[0].split('-')[1].to_i - 1
	letter = tuple[1].split(':')[0]
	password = tuple[2]

	if (password[pos1] == letter || password[pos2] == letter) 
		if (password[pos1] != password[pos2])
			num_valid += 1
		end
	end	
	
end
puts num_valid
