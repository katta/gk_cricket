class WeightedRandomizer

  def initialize(weights, items)
    @weights = weights
    @items = items
    @weighted_items = []

    generate_weighted_items
  end

  def randomItem
    @weighted_items[random(@weighted_items.size)]
  end

  private

  def generate_weighted_items
    @weights.each_with_index do |weight, index|
      (weight*100).to_i.times { @weighted_items << @items[index] }
    end
  end

  def random(max)
    Random.new.rand(max)
  end

end
