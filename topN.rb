require "./classes"
FILENAME = "data.txt"

File.open("data.txt", "w+") { |f|
  500000.times.map { f.write("#{Random.rand(1...99999999)}\n") }
}

print "Please enter the n number: "
input = gets.chomp()
puts TopN.find_top_numbers(FILENAME, input)