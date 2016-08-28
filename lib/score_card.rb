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

  def print_batting_card
    batsmen = {}

    @over_matrix.each do |over, ocr_hash|
      ocr_hash.each do |ball, card|
        name = card.batsman.name
        if batsmen[name].nil?
          batsmen[:name] = {score:0, balls:0}
        end
        batsmen[:balls] += 1
        batsmen[:score] += card.score_to_i
      end
    end

    batsmen.each do |name, stats|
      puts "#{name} - #{stats[:score]} (#{stats[:balls]})"
    end

  end
end
