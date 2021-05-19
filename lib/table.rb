# frozen_string_literal: true

# Module that takes the data and convert to the score card(table) format
module Table
  def self.print_output(data)
    string = 'Frame'.ljust(10)
    string = (1...10).inject(string) { |output, i| output + i.to_s.ljust(8) }
    string += "10\n"
    data.each do |player_name, score|
      current_player = Player.new(player_name)
      current_score = Score.new({ player: current_player, score: score })
      string += "#{current_player.name}\n"
      string += 'Pinfalls'.ljust(10)
      string = current_score.print_pinfalls.inject(string) do |output, pin|
        output + "#{pin[0]}   #{pin[1]}".ljust(8)
      end
      string += current_score.print_pinfalls[-1][-1].to_s if current_score.print_pinfalls[-1].length == 3
      string += "\nScore".ljust(11)
      string = current_score.compute_score.inject(string) { |output, pin| output + pin.to_s.ljust(8) }
      string += "\n"
    end
    string
  end
end
