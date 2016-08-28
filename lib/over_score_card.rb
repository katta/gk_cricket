class OverScoreCard

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

  attr_accessor  :batsman
  attr_accessor  :bowler
  attr_accessor  :score
  attr_accessor  :ball

  def to_s
    str = "#{@ball/10.to_f} #{@batsman.name} "
    if score == :out
      str += "gets out !!"
    elsif score == :one
      str += "scores #{score_to_i} run"
    else
      str += "scores #{score_to_i} runs"
    end
    str
  end

  def score_to_i
    RUNS_IN_NUMBERS[@score]
  end
end
