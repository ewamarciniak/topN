require "test/unit"
require "./classes"

class TopNTest < Test::Unit::TestCase
  def test_check_find_top_numbers
    #generate the file to be used

    expected_results = [
      {
        file_name: "./testing_data.txt",
        input: "6",
        result: "9999839570, 9999801840, 9999752617, 9999739013, 9999706448, 9999699800"
      },
      {
        file_name: "./testing_data.txt",
        input: "NaN",
        result: "Entered value is not a number."
      }
    ]

    expected_results.each do |expected_result|
      assert_equal expected_result[:result], TopN.find_top_numbers(expected_result[:file_name], expected_result[:input])
    end
  end

  def test_numeric

    expected_results = [
      {
        input: "Number",
        result: false
      },
      {
        input: "77",
         result: true
      }
    ]

    expected_results.each do |expected_result|
      assert_equal expected_result[:result], expected_result[:input].numeric?
    end
  end

end