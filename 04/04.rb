def is_valid_passport? passport
	result = true

	result = result && (is_valid_birth_year? passport)
	result = result && (is_valid_issue_year? passport)
	result = result && (is_valid_expir_year? passport)
	result = result && (is_valid_height? passport)
	result = result && (is_valid_hair_color? passport)
	result = result && (is_valid_eye_color? passport)
	result = result && (is_valid_passport_id? passport)

	return result
end


def is_valid_birth_year? passport
	result = true
	result = false if passport['byr'].to_i < 1920
	result = false if passport['byr'].to_i > 2002
	return result
end
def is_valid_issue_year? passport
	result = true
	result = false if passport['iyr'].to_i < 2010
	result = false if passport['iyr'].to_i > 2020
	return result
end
def is_valid_expir_year? passport
	result = true
	result = false if passport['eyr'].to_i < 2020
	result = false if passport['eyr'].to_i > 2030
	return result
end
def is_valid_height? passport
	result = true
	if passport['hgt'].include? "cm"
		cms = passport['hgt'][0...-2].to_i
		result = false if cms < 150
		result = false if cms > 193
	elsif passport['hgt'].include? "in"
		ins = passport['hgt'][0...-2].to_i
		result = false if ins < 59
		result = false if ins > 76		
	else 
		result = false
	end
	return result
end
def is_valid_hair_color? passport
	result = true
	result = false if passport['hcl'][0] != '#'
	result = false if passport['hcl'].length != 7
	result = false if passport['hcl'][1...7].downcase =~ ["g-z"]
	return result
end
# 
def is_valid_eye_color? passport
	%w(amb blu brn gry grn hzl oth).include?(passport['ecl'])
end
def is_valid_passport_id? passport
	return passport['pid'].length == 9
end


file = File.open("input.txt")
file_data = file.readlines.map(&:chomp)
file.close


raw_passports = []
current = ""

file_data.each do |line|
	current << " #{line} "
	if line.to_s.strip.empty?
		raw_passports << " #{current} "
		current = ""
	end
end

passports = []
raw_passports.each do |raw_passport|
	result = {}
	kvs = raw_passport.gsub(/\s+/m, ' ').strip.split(" ")
	kvs.each do |kv|
		result[kv.split(':')[0]] = kv.split(':')[1]
	end
	passports << result
end

valid_count = 0
almost_valid_count = 0

review = []

passports.each do |passport| 
	if (passport.length == 8) || (passport.length == 7 && passport['cid'].nil?)
		valid_count += 1
		review << passport
	end
end

puts "total passports: #{passports.length}"
puts "number valid: #{valid_count}"

valid_count = 0
review.each do |passport| 
	valid_count += 1 if is_valid_passport? passport
end
puts "number valid: #{valid_count}"


