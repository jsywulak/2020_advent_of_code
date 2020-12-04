def is_valid_passport?(passport)
  (is_valid_birth_year? passport) &&
    (is_valid_issue_year? passport) &&
    (is_valid_expir_year? passport) &&
    (is_valid_height? passport) &&
    (is_valid_hair_color? passport) &&
    (is_valid_eye_color? passport) &&
    (is_valid_passport_id? passport)
end

def is_valid_birth_year?(passport)
  result = true
  result = false if passport['byr'].to_i < 1920
  result = false if passport['byr'].to_i > 2002
  result
end

def is_valid_issue_year?(passport)
  result = true
  result = false if passport['iyr'].to_i < 2010
  result = false if passport['iyr'].to_i > 2020
  result
end

def is_valid_expir_year?(passport)
  result = true
  result = false if passport['eyr'].to_i < 2020
  result = false if passport['eyr'].to_i > 2030
  result
end

def is_valid_height?(passport)
  result = true
  if passport['hgt'].include? 'cm'
    cms = passport['hgt'][0...-2].to_i
    result = false if cms < 150
    result = false if cms > 193
  elsif passport['hgt'].include? 'in'
    ins = passport['hgt'][0...-2].to_i
    result = false if ins < 59
    result = false if ins > 76
  else
    result = false
  end
  result
end

def is_valid_hair_color?(passport)
  result = true
  result = false if passport['hcl'][0] != '#'
  result = false if passport['hcl'].length != 7
  result = false if passport['hcl'][1...7].downcase =~ ['g-z']
  result
end

def is_valid_eye_color?(passport)
  %w[amb blu brn gry grn hzl oth].include?(passport['ecl'])
end

def is_valid_passport_id?(passport)
  passport['pid'].length == 9
end

def parse_raw_passport_data(data)
  raw_passports = []
  current = ''
  data.each do |line|
    current << " #{line} "
    if line.to_s.strip.empty?
      raw_passports << " #{current} "
      current = ''
    end
  end
  raw_passports
end

def parse_passport_data(raw_passports)
  passports = []
  raw_passports.each do |raw_passport|
    result = {}
    kvs = raw_passport.gsub(/\s+/m, ' ').strip.split(' ')
    kvs.each do |kv|
      result[kv.split(':')[0]] = kv.split(':')[1]
    end
    passports << result
  end
  passports
end

def parse_correct_number_of_fields(passports)
  result = []
  passports.each do |passport|
    result << passport if (passport.length == 8) || (passport.length == 7 && passport['cid'].nil?)
  end
  result
end

def parse_valid_data_in_fields(passports)
  result = []
  passports.each do |passport|
    result << passport if is_valid_passport? passport
  end
  result
end

def get_input_data
  file = File.open('input.txt')
  file_data = file.readlines.map(&:chomp)
  file.close

  file_data
end

file_data = get_input_data
raw_passports = parse_raw_passport_data file_data
passports = parse_passport_data raw_passports
valid_passports = parse_correct_number_of_fields passports
really_valid_passports = parse_valid_data_in_fields valid_passports

puts "total passports: #{passports.length}"
puts "number with correct number of fields: #{valid_passports.length}"
puts "number with correct data in fields: #{really_valid_passports.length}"
