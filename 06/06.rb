# frozen_string_literal: true

require 'set'

def read_input_data
  file = File.open('input.txt')
  file_data = file.readlines.map(&:chomp)
  file.close

  file_data
end

def parse_customs_data(data)
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
  groups
end

#  smush all the people together in a single string, then make a Set from the characters
#  Sets only allow one of each item, so the length of that will be the total.
def total_anyone_yes(groups)
  total = 0
  groups.each do |group|
    group_answers = Set.new(group.join.chars)
    total += group_answers.length
  end
  total
end

# beyond here lies regexes.
# https://stackoverflow.com/questions/1660694/regular-expression-to-match-any-character-being-repeated-more-than-10-times
# basically find any time any chracter appears N times, where N is the size of the group.
def total_everyone_yes(groups)
  total = 0
  groups.each do |group|
    group_answers = group.join.chars.sort.join.scan(/(.)\1{#{group.length - 1},}/)
    total += group_answers.length
  end
  total
end

data = read_input_data
groups = parse_customs_data data

total = total_anyone_yes groups
puts "total for anyone answering yes: #{total}"

total = total_everyone_yes groups
puts "total for everyone answering yes: #{total}"
