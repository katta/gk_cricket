require 'team'
require 'score_card'
require 'over'
require 'score'
require 'all_out_error'
require 'game_over'

class Innings
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

    rotate_strike(@striker, @runner) if (score.rotate_strike?)
    rotate_strike(@striker, @runner) if Over.last_ball?(current_ball)

    @runner = next_batsman if score.out? & Over.last_ball?(current_ball)
    @striker = next_batsman if score.out? & !Over.last_ball?(current_ball)
  end

  def start(runs_to_win, no_of_overs)
    begin
      no_of_overs.times do |current_over|
        over = Over.new(self, current_over)
        over.play do |current_ball, score|
          record_score(score, current_over + 1, current_ball)
          raise GameOver, "Team won the match !!" if @score_card.total_score >= runs_to_win
        end
      end
    rescue GameOver => e
      puts e.message
    rescue AllOutError
      ## do nothing
    end
    @score_card
  end

  private

  def rotate_strike(striker, runner)
    @striker = runner
    @runner = striker
  end

  def next_batsman
    @batting_team.next_player(@score_card.all_batsmen.keys | [@striker.name, @runner.name])
  end
end
