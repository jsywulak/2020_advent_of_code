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

def execute_program(lines, log=false)
  exit_code = 1
  accumulator = 0

  history = []
  i = 0
  loop do
    if history.include? i
      exit_code = 1
      if log
	      puts "loop detected:"
	      puts "\taccumulator: #{accumulator}"
	      puts "\thistory: #{history.length}"
	   end
      return exit_code
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

    if i >= lines.length
      puts 'program exited normally'
      exit_code = 0
      break
    end
  end

  puts "history: [#{history}]"
  puts "accumulator: #{accumulator}"
  exit_code
end

lines = read_input_data

# part one

execute_program lines, true


i = 0

loop do
  working_copy = lines.clone.map(&:clone)
  break if i >= lines.length
  exit_code = 1

  if working_copy[i].split(" ")[0] == "nop"
  	working_copy[i].sub!("nop", "jmp")
  	exit_code = execute_program working_copy
  elsif working_copy[i].split(" ")[0] == "jmp"
  	working_copy[i].sub!("jmp", "nop")
  	exit_code = execute_program working_copy
  end 
  if exit_code == 0
  	puts "successful execution changing line #{i}"
  	break
  end
  i += 1
end
