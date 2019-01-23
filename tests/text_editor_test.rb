require 'minitest/autorun'
require_relative '../text_editor'

class TextEditorTest < Minitest::Test
  def setup
    @te = TextEditor.new
  end

  # Should I only test that Buffer#append gets called?
  def test_handle_input_handles_append
    assert_equal(@te.buffer.text, '')
    @te.handle_input('1 texttoappend')
    assert_equal(@te.buffer.text, 'texttoappend')
    stored_command = @te.commands.last
    assert_equal(stored_command.method, :append)
    assert_equal(stored_command.args, ['texttoappend'])
  end

  def test_handle_input_handles_delete
    @te.handle_input('1 startertext')
    assert_equal(@te.buffer.text, 'startertext')
    @te.handle_input('2 4')
    assert_equal(@te.buffer.text, 'starter')
    stored_command = @te.commands.last
    assert_equal(stored_command.method, :delete)
    assert_equal(stored_command.args, ['4'])
  end

  def test_handle_input_calls_print_on_buffer
    @te.handle_input('1 startertext')
    assert_equal(@te.buffer.text, 'startertext')
    assert_output("r\n", '') do
      @te.handle_input('3 4')
    end
  end

  # Q: Should I test internals of TextEditor#undo and TextEditor#update_history?
  # These might count as 'incoming commands', so I might add tests for correct
  # changes to @snapshot, @commands, and @history.
  # A: This does need further testing, but instead of testing internals like
  # @snapshot, @commands, and @history, I should add more scenarios that test
  # e.g. > MAX_COMMANDS_LENGTH commands and undos
  def test_handle_input_handles_undo
    @te.handle_input('1 startertext')
    assert_equal(@te.buffer.text, 'startertext')
    @te.handle_input('4')
    assert_equal(@te.buffer.text, '')
  end
end
