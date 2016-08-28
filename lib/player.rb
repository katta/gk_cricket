class Player
  attr_reader :scoring_probability

  def initialize(name, scoring_probability)
    @name = name
    @scoring_probability = scoring_probability
  end
end
