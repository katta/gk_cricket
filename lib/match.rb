require 'innings'

class Match
  def initialize(team1, team2)
    @team1 = team1
    @team2 = team2
  end

  def toss
    @all_innings = {first: Innings.new(@team1, @team2), second: Innings.new(@team2, @team1)}
  end

  def play(innings, runs_to_win, no_of_overs)
    @all_innings[innings].start(runs_to_win, no_of_overs)
  end
end
