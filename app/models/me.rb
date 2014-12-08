module Me

  def self.current
    Thread.current[:me]
  end

  def self.current=(current_actor)
    Thread.current[:me] = current
  end

end
