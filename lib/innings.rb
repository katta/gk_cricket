require 'over'
require 'team_innings'
require 'all_out_error'

class Innings
  MAX_OVERS = 4

  def initialize(batting_team, bowling_team)
    @team_innings = TeamInnings.new(batting_team, bowling_team)
  end

  def start
    begin
      MAX_OVERS.times do |current_over|
        over = Over.new(@team_innings, current_over)
        over.play do |current_ball, score|
          @team_innings.record_score(score, current_over + 1, current_ball)
        end
      end
    rescue AllOutError
      ## do nothing
    end
    @team_innings.score_card
  end
end
