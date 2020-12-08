# frozen_string_literal: true

def read_input_data
  file = File.open('input.txt')
  file_data = file.readlines.map(&:chomp)
  file.close
  file_data
end

def parse_line(line)
  { command: line.split(' ')[0], value: line.split(' ')[1].to_i }
end

lines = read_input_data
accumulator = 0

history = []

i = 0
loop do
  if history.include? i
    puts "accumulator at #{accumulator} when loop detected"
    break
  end
  history << i

  command = parse_line lines[i]
  case command[:command]
  when 'acc'
    accumulator += command[:value]
    i += 1
  when 'nop'
    i += 1
  when 'jmp'
    i += command[:value]
  else
    "invalid command #{command[:command]}"
  end
end

puts "history: [#{history}]"
puts "accumulator: #{accumulator}"
