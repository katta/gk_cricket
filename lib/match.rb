require 'innings'

class Match
  def initialize(team1, team2)
    @team1 = team1
    @team2 = team2
  end

  def toss
    @all_innings = {first: Innings.new(@team1, @team2), second: Innings.new(@team2, @team1)}
  end

  def play(innings, runs_to_win)
    @all_innings[innings].start runs_to_win
  end
end
