class Command
  attr_reader :method, :args

  def initialize(method, *args)
    @method = method
    @args = args
  end

  def execute(receiver)
    receiver.send(@method, *@args)
  end
end
