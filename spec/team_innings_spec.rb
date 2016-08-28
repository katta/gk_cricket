require 'team_innings'
require 'player'
require 'team'

describe TeamInnings do

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
    Player.new('Shashi Henra', {})
  }
  let(:player5) {
    Player.new('Ram Kumar', {})
  }

  subject {
    batting_team = Team.new([player1, player2, player3])
    bowling_team = Team.new([player4, player5])
    TeamInnings.new(batting_team, bowling_team)
  }

  context 'should record score' do
    current_over = 1
    current_ball = 1

    it 'when its 3 runs' do
      subject.record_score(:three, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:three)
    end

    it 'when its 1 run' do
      subject.record_score(:one, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:one)
    end

    it 'when its out' do
      subject.record_score(:out, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:out)
    end

    it 'when its a dot ball' do
      subject.record_score(:dot, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:dot)
    end
  end

  context 'should change striker' do
    current_over = 1
    current_ball = 1

    it 'when the score is 1 run' do
      subject.record_score(:one, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:one)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to_not eq(subject.striker)
    end

    it 'when the score is 3 runs' do
      subject.record_score(:three, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:three)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to_not eq(subject.striker)

    end

    it 'when the score is 5 runs' do
      subject.record_score(:five, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:five)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to_not eq(subject.striker)
    end

    it 'when its the last ball of the over and its a dot ball' do
      current_ball = 6
      subject.record_score(:dot, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:dot)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to_not eq(subject.striker)
    end

    it 'when its the last ball of the over and its 2 runs' do
      current_ball = 6
      subject.record_score(:two, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:two)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to_not eq(subject.striker)
    end

    it 'when its the last ball of the over and its 4 runs' do
      current_ball = 6
      subject.record_score(:four, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:four)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to_not eq(subject.striker)
    end

    it 'when its the last ball of the over and its 6 runs' do
      current_ball = 6
      subject.record_score(:six, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:six)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to_not eq(subject.striker)
    end


  end

  context 'should not change striker' do
    current_over = 1
    current_ball = 1

    it 'when the score is 2 runs' do
      subject.record_score(:two, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:two)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to eq(subject.striker)
    end

    it 'when the score is 4 runs' do
      subject.record_score(:four, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:four)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to eq(subject.striker)
    end

    it 'when the score is 6 runs' do
      subject.record_score(:six, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:six)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to eq(subject.striker)
    end

    it 'when its the last ball and the score is 3 runs' do
      current_ball = 6
      subject.record_score(:three, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:three)
      expect(score_card.over_matrix[current_over][current_ball].batsman).to eq(subject.striker)
    end
  end

  context 'should get new batsman as striker' do
    current_over = 1
    current_ball = 1

    it 'when the batsman gets out' do
      subject.record_score(:out, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:out)
      expect(subject.striker).to eq(player3)
    end
  end

  context 'should get new batsman as runner' do
    current_over = 1
    current_ball = 6

    it 'when the batsman gets out and its a last ball of the over' do
      subject.record_score(:out, current_over, current_ball)

      score_card = subject.score_card
      expect(score_card.over_matrix[current_over][current_ball].score).to eq(:out)
      expect(subject.striker).to eq(player2)
      expect(subject.runner).to eq(player3)
    end
  end
end
