class OverScoreCard
  attr_accessor  :batsman
  attr_accessor  :bowler
  attr_accessor  :score
  attr_accessor  :ball

  def to_s
    str = "#{@ball/10.to_f} #{@batsman.name} "
    if @score.out?
      str += "gets out !!"
    elsif @score.single?
      str += "scores #{score.to_i} run"
    else
      str += "scores #{score.to_i} runs"
    end
    str
  end
end
