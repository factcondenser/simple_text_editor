require 'minitest/autorun'

class MainScriptTest < Minitest::Test
  def test_main_script_generates_correct_output
    # filepath = 'fixtures/files/output2.txt'
    # output = File.read(filepath)
    # puts output
    output = %w[n p x s p p p i l p d x z b x s n].join("\n")
    # output = "n\n"
    # assert_output(output, '') do
    #   %x(cat fixtures/files/input2.txt | ruby ../main_script.rb)
    # end

    out, err = capture_subprocess_io do
      %x(cat fixtures/files/input2.txt | ruby ../main_script.rb)
    end

    assert_equal output, out
    assert_equal '', err
  end
end
