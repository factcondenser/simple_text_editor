# Manipulates an internal string based on formatted input
class TextEditor
  def initialize
    @text = ''
    @history = []
  end

  def append(str, store: true)
    @text << str
    @history.push(['2', str.length]) if store
  end

  def delete(idx, store: true)
    deleted = @text[-idx..-1]
    @text = @text[0...-idx]
    @history.push(['1', deleted]) if store
  end

  def print(idx)
    puts @text[idx - 1]
  end

  def undo
    action, arg = @history.pop
    case action
    when '1'
      append(arg, store: false)
    when '2'
      delete(arg, store: false)
    end
  end
end
