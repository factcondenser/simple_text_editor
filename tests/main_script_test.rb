require 'minitest/autorun'

class MainScriptTest < Minitest::Test
  def test_main_script_generates_correct_output
    filepath = 'tests/fixtures/files/output_large.txt'
    expected = File.read(filepath) + "\n"
    actual = `cat tests/fixtures/files/input_large.txt | ruby main_script.rb`
    assert_equal(expected, actual)
  end
end
