require 'minitest/autorun'
require_relative '../command'

class CommandTest < Minitest::Test
  def test_execute_sends_message_with_args_to_given_receiver
    receiver = 'I will receive a message.'
    command = Command.new(:gsub!, 'will receive', 'received')
    command.execute(receiver)
    assert_equal(receiver, 'I received a message.')
  end
end
