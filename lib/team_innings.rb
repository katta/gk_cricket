require 'team'
require 'score_card'
require 'over'

class TeamInnings
  attr_accessor :striker
  attr_accessor :runner
  attr_accessor :bowler
  attr_reader :score_card

  def initialize(batting_team, bowling_team)
    @score_card = ScoreCard.new

    @batting_team = batting_team
    @bowling_team = bowling_team

    @striker = batting_team.players[0]
    @runner = batting_team.players[1]
    @bowler = bowling_team.players.first

    @batsmen = [@striker, @runner]
    @bowlers = [@bowler]
  end

  def record_score(score, current_over, current_ball)
    @score_card.record(@striker, @bowler, score, current_over, current_ball)

    if Over.last_ball?(current_ball)
      rotate_strike(@striker, @runner) if !([:one,:three,:five].include? score)
      @runner = next_batsman if score == :out
    else
      if ([:one,:three,:five].include? score)
        rotate_strike(@striker, @runner)
      elsif score == :out
        @striker = next_batsman
      end
    end
  end

  private

  def rotate_strike(striker, runner)
    @striker = runner
    @runner = striker
  end

  def next_batsman
    @batting_team.next_player(@score_card.all_batsmen.keys | [@striker.name, @runner.name])
  end

  def last_ball current_ball
     current_ball == 6
  end
end
