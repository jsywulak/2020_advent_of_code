file = File.open("input.txt")
file_data = file.readlines.map(&:chomp)
file.close

file_data.each do |fnumber|
	difference = 2020 - fnumber.to_i
	
	if file_data.include?(difference.to_s)
		puts "d[#{difference}], f_num[#{fnumber}], p[#{(difference * fnumber.to_i)}]" 
		break
	end
end

found = false
file_data.each do |fnumber|
	file_data.each do |snumber|
		difference = 2020 - fnumber.to_i - snumber.to_i		
		if file_data.include?(difference.to_s)
			found = true
			puts "d[#{difference}], f_num[#{fnumber}], s_num[#{snumber}], p[#{(difference * fnumber.to_i * snumber.to_i)}]" 
			break
		end
		break if found
	end
end
