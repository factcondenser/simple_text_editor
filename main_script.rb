require_relative 'text_editor'

input = ARGF.read
lines = input.split("\n")
te = TextEditor.new
lines.drop(1).each do |line|
  action, arg = line.split(' ')
  case action
  when '1'
    te.append(arg)
  when '2'
    te.delete(arg.to_i)
  when '3'
    te.print(arg.to_i)
  when '4'
    te.undo
  end
end
