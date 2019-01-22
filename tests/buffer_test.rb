require 'minitest/autorun'
require_relative '../buffer'

class BufferTest < Minitest::Test
  def test_append_appends_string_to_text
    buffer = Buffer.new
    assert_equal(buffer.text, '')
    buffer.append('Hello, world!')
    assert_equal(buffer.text, 'Hello, world!')
  end

  def test_append_with_existing_text
    buffer = Buffer.new('Existing text')
    assert_equal(buffer.text, 'Existing text')
    buffer.append(' should not be overwritten.')
    assert_equal(buffer.text, 'Existing text should not be overwritten.')
  end

  def test_delete_deletes_last_k_characters_of_text
    buffer = Buffer.new('Some text to delete')
    assert_equal(buffer.text, 'Some text to delete')
    buffer.delete('8')
    assert_equal(buffer.text, 'Some text t')
  end

  def test_print_outputs_kth_char_of_text
    buffer = Buffer.new('The eighth character is h.')
    assert_output("h\n", '') do
      buffer.print('8')
    end
  end

  def test_take_snapshot_returns_new_buffer_with_copied_text
    buffer = Buffer.new('Text to be copied over')
    snapshot = buffer.take_snapshot
    refute_same(snapshot, buffer)
    assert_equal(snapshot.text, 'Text to be copied over')
    refute_same(snapshot.text, buffer.text)
  end
end
