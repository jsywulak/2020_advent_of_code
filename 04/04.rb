def is_valid_passport? passport
	result = true

	is_valid_birth_year? passport
	is_valid_issue_year? passport
	is_valid_expir_year? passport
	is_valid_height? passport
	is_valid_hair_color? passport
	is_valid_eye_color? passport
	is_valid_passport_id? passport

	return result
end


def is_valid_birth_year? passport
	true
end
def is_valid_issue_year? passport
	true
end
def is_valid_expir_year? passport
	true
end
def is_valid_height? passport
	true
end
def is_valid_hair_color? passport
	true
end
def is_valid_eye_color? passport
	true
end
def is_valid_passport_id? passport
	true
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


