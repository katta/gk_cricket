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
    @over_matrix.keys.reverse.each do |current_over|
      puts "#{current_over} overs left:"
      puts ""

      ocr_hash = @over_matrix[current_over]
      (1..6).each do |current_ball|
        ocr = ocr_hash[current_ball]
        puts ocr
      end
      puts ""
    end
  end
end
