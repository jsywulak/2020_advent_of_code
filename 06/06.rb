require 'set'

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
	group_answers = Set.new(group.join.chars)
	total += group_answers.length
end
puts "total for anyone answering yes: #{total}"

total = 0
groups.each do |group|
	group_answers = group.join.chars.sort.join.scan(/(.)\1{#{group.length - 1},}/)
	total += group_answers.length
end
puts "total for everyone answering yes: #{total}"
