class Score
  RUNS_IN_NUMBERS = {
    one: 1,
    two: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    dot: 0,
    out: 0
  }

  def initialize(score)
    @score = score
  end

  def rotate_strike?
    [:one,:three,:five].include? @score
  end

  def out?
    @score == :out
  end

  def single?
    @score == :one
  end

  def to_i
    RUNS_IN_NUMBERS[@score]
  end
end
