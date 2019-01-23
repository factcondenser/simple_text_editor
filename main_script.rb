require_relative 'text_editor'

te = TextEditor.new
ARGF.each_line do |line|
  te.handle_input(line)
end
