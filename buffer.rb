class Buffer
  attr_reader :text

  def initialize(str = '')
    @text = str
  end

  def append(str)
    @text << str
  end

  def delete(idx)
    @text.slice!(-idx.to_i..-1)
  end

  def print(idx)
    puts @text[idx.to_i - 1]
  end

  def take_snapshot
    Buffer.new(@text.dup)
  end
end
