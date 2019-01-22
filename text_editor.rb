require_relative 'buffer'
require_relative 'command'

# Manipulates an internal string based on formatted input
class TextEditor
  MAX_COMMANDS_LENGTH = 50
  METHODS = {
    '1' => :append,
    '2' => :delete,
    '3' => :print,
    '4' => :undo
  }.freeze

  attr_reader :buffer, :commands

  def initialize
    @buffer = Buffer.new
    @snapshot = @buffer.take_snapshot
    @commands = []
    @history = []
  end

  def handle_input(input)
    method_code, *args = input.split(' ')
    method = METHODS[method_code]
    case method
    when :append, :delete
      update_history(method, *args)
      @buffer.send(method, *args)
    when :print
      @buffer.send(method, *args)
    when :undo
      undo
    end
  end

  private

  def undo
    @snapshot, @commands = @history.pop if @commands.empty?
    @buffer = @snapshot.take_snapshot
    @commands.tap(&:pop).each do |command|
      command.execute(@buffer)
    end
  end

  def update_history(method, *args)
    if @commands.length == MAX_COMMANDS_LENGTH
      @history.push([@snapshot, @commands])
      @snapshot = @buffer.take_snapshot
      @commands = []
    end
    @commands << Command.new(method, *args)
  end
end
