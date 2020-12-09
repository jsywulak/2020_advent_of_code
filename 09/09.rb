# frozen_string_literal: true

def read_input_data
  file = File.open('input.txt')
  file_data = file.readlines.map(&:chomp)
  file.close
  file_data
end

lines = read_input_data

working_set_size = 25
i = working_set_size

numbers = lines.map(&:to_i)

part1 = 0

loop do
  break if i >= numbers.length

  start = i - working_set_size - 1
  start = 0 if start.negative?
  finish = i - 1
  finish = numbers.length if finish > numbers.length

  working_set = numbers[start...finish].sort
  largest = working_set.last(2).inject(0, :+)
  smallest = working_set.first(2).inject(0, :+)
  if smallest > numbers[i] || numbers[i] > largest
    puts "part 1: #{numbers[i]}"
    part1 = numbers[i]
    break
  end
  i += 1
end

result = 0
until result != 0
  upper = rand(numbers.length)
  lower = rand(upper)
  next unless part1 == numbers[lower...upper].inject(0, :+)

  min = numbers[lower...upper].min
  max = numbers[lower...upper].max
  result = min + max
end

puts "part 2: #{result}"
