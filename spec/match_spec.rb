require 'match'
require 'team'
require 'player'

describe Match do
  let(:player1) {
    Player.new('Kirat Boli', {dot: 0.05, one: 0.3, two:0.25, three:0.1, four:0.15, five:0.01, six:0.09, out:0.05 })
  }
  let(:player2) {
    Player.new('N.S Nodhi', {dot: 0.1, one: 0.4, two:0.2, three:0.05, four:0.1, five:0.01, six:0.04, out:0.1 })
  }
  let(:player3) {
    Player.new('R Rumrah', {dot: 0.2, one: 0.3, two:0.15, three:0.05, four:0.05, five:0.01, six:0.04, out:0.2 })
  }
  let(:player4) {
    Player.new('Shashi Henra', {dot: 0.3, one: 0.25, two:0.05, three:0.0, four:0.05, five:0.01, six:0.04, out:0.3 })
  }

  it 'should play' do
    team1 = Team.new([Player.new("Bowler1", {}), Player.new("Bowler2", {})])
    team2 = Team.new([player1, player2, player3, player4])

    match = Match.new(team1, team2)
    match.toss
    score_card = match.play(:second)

    puts "****************************"
    score_card.print_batting_card
    puts "****************************"
    puts ""
    score_card.print_commentary
  end
end
