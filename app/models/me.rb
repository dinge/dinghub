module Me

  def self.current
    Thread.current[:me_current]
  end

  def self.current=(current_actor)
    Thread.current[:me_current] = current_actor
  end

end
