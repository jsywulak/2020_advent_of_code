def read_input_data
  file = File.open('input.txt')
  file_data = file.readlines.map(&:chomp)
  file.close

  file_data
end

data = read_input_data
current = []
groups = []
data.each do |line|
    if line.to_s.strip.empty?
    	groups << current
    	current = []
    else
    	current << line
    end
end

total = 0
groups.each do |group|
	group_answers = group.join.chars.sort.to_a.uniq
	total += group_answers.length
end
puts "total: #{total}"

