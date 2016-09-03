require 'weighted_randomizer'
require 'innings'
require 'score'

class Over
  MAX_BALLS = 6

  def initialize(innings, current_over)
    @innings = innings
    @current_over = current_over
  end

  def play
    MAX_BALLS.times do |current_ball|
      current_striker = @innings.striker
      weighted_randomizer = WeightedRandomizer.new(current_striker.scoring_probability.keys, \
        current_striker.scoring_probability.values)
      score = weighted_randomizer.randomItem
      yield(current_ball + 1, Score.new(score))
    end
  end

  def self.last_ball? (ball)
    ball == MAX_BALLS
  end

end
