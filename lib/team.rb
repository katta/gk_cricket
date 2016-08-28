require 'all_out_error'

class Team
  attr_reader :players

  def initialize(players)
    @players = players
  end

  def next_player(exclude_player_names)
    @players.each do |player|
      if !(exclude_player_names.include? player.name)
        return player
      end
    end
    raise AllOutError, "All Out !!"
  end
end
