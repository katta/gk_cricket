require 'weighted_randomizer'
require 'team_innings'

class Over
  MAX_BALLS = 6

  def initialize(team_innings, current_over)
    @team_innings = team_innings
    @current_over = current_over
  end

  def play
    MAX_BALLS.times do |current_ball|
      current_striker = @team_innings.striker
      weighted_randomizer = WeightedRandomizer.new(current_striker.scoring_probability.keys, \
        current_striker.scoring_probability.values)
      score = weighted_randomizer.randomItem      
      yield(current_ball + 1, score)
    end
  end

end
