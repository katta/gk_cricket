require 'over_score_card'

class ScoreCard
  attr_reader :over_matrix
  attr_reader :total_score

  def initialize
    @over_matrix = {}
    @total_score = 0
  end

  def record(batsman, bowler, score, current_over, current_ball)
    over_score_card = OverScoreCard.new
    over_score_card.batsman = batsman
    over_score_card.bowler = bowler
    over_score_card.score = score
    over_score_card.ball = current_ball

    @total_score += score.to_i

    if @over_matrix[current_over].nil?
      @over_matrix[current_over] = {}
    end

    @over_matrix[current_over][current_ball] = over_score_card
  end

  def print_commentary(no_of_overs)
    @over_matrix.keys.each do |over|
      puts "#{(no_of_overs+1) - over} overs left:"
      puts ""
      (1..Over::MAX_BALLS).each { |ball| puts @over_matrix[over][ball] }
      puts ""
    end
  end

  def print_batting_card
    batting_card.each do |name, stats|
      puts "#{name} - #{stats[:score]} (#{stats[:balls]})"
    end
  end

  def all_batsmen
    batting_card
  end

  private

  def batting_card
    batsmen = {}
    @over_matrix.keys.each do |over|
      @over_matrix[over].each do |ball, card|
        name = card.batsman.name
        if batsmen[name].nil?
          batsmen[name] = {score:0, balls:0}
        end
        batsmen[name][:balls] += 1
        batsmen[name][:score] += card.score.to_i
      end
    end

    batsmen
  end
end
