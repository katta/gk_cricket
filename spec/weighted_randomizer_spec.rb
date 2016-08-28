require 'weighted_randomizer'

describe WeightedRandomizer do
  it 'shoud pick weighted random item' do
    weights = [0.3, 0.2, 0.5]
    items = ['six', 'four', 'one']

    wrn = described_class.new(items, weights)
    expect(items).to include wrn.randomItem
  end
end
