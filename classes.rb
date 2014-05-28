require 'set'

class File
  MEGABYTE = 1024*1024

  def get_max_n(chunk_size)
    self.read(chunk_size)
  end

  def each_chunk(chunk_size=MEGABYTE)
    yield self.get_max_n(chunk_size) until self.eof?
  end
end

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class TopN

  def self.find_top_numbers(file_name, input)

    left_over = ''
    top_n = []

    if input.numeric?
      n = input.to_i

      open(file_name, "rb") do |f|
        f.each_chunk do |chunk|

          #check if there are any left overs from previous iterations
          if !left_over.empty?
            chunk.insert(0, left_over)
            #remove the used leftover
            left_over = ""
          end

          #turn the string into array
          arry = chunk.split("\r\n")

          #if the string is not cut perfectly add to left overs
          left_over = arry.pop if !chunk.end_with?("\r\n")

          #select top n uniq numbers from the chunk
          arry = arry.collect { |x| x.to_i }.uniq

          #add the top n numbers from this set to the array of current top n
          top_n << arry

          #narrow down the combined num array to the top n values
          top_n = top_n.flatten.sort_by { |k| -k }.uniq.take(n)
        end
      end


      if !left_over.empty?
        top_n << left_over.to_i
        top_n = top_n.sort_by { |k| -k }.uniq.take(n)
      end

      return top_n.join(", ")

    else
      return "Entered value is not a number."
    end
  end
end


