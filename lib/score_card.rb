require 'over_score_card'

class ScoreCard
  attr_reader :over_matrix

  def initialize
    @over_matrix = {}
  end

  def record(batsman, bowler, score, current_over, current_ball)
    over_score_card = OverScoreCard.new
    over_score_card.batsman = batsman
    over_score_card.bowler = bowler
    over_score_card.score = score
    over_score_card.ball = current_ball

    if @over_matrix[current_over].nil?
      @over_matrix[current_over] = {}
    end

    @over_matrix[current_over][current_ball] = over_score_card
  end

  def print_commentary
    @over_matrix.keys.reverse.each do |over|
      puts "#{over} overs left:"
      puts ""
      (1..Over::MAX_BALLS).each { |ball| puts @over_matrix[over][ball] }
      puts ""
    end
  end

  # def print_batting_card
  #   batsmen = []
  #   batsman = {}
  #
  #   # @over_matrix.each do |current_over, over_score_card_hash|
  #   #   over_score_card_hash.each do |current_ball, |
  #
  # end

end
