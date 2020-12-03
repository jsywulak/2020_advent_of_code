def check_slope(landscape, slope_right, slope_down)
	trees = 0
	pos = 0
	landscape.each_with_index do |line, index|
		if index % slope_down == 0
			if line[pos] == '#'
				trees += 1
			end
			pos = (pos + slope_right) % line.length
		end
	end
	return trees
end


file = File.open("input.txt")
file_data = file.readlines.map(&:chomp)
file.close

result = 1

trees = check_slope(file_data, 3, 1)
result *= trees
puts "down: 1, right: 3, trees: #{trees}"

trees = check_slope(file_data, 1, 1)
result *= trees
puts "down: 1, right: 1, trees: #{trees}"

trees = check_slope(file_data, 5, 1)
result *= trees
puts "down: 1, right: 5, trees: #{trees}"

trees = check_slope(file_data, 7, 1)
result *= trees
puts "down: 1, right: 7, trees: #{trees}"

trees = check_slope(file_data, 1, 2)
result *= trees
puts "down: 2, right: 1, trees: #{trees}"

puts "result: #{result}"
