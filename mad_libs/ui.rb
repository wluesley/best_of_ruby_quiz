class ConsoleUi
  def ask(prompt)
    print prompt + " "
    answer = gets
    answer ? answer.chomp : nil
  end

  def say(*msg)
    puts msg
  end
end