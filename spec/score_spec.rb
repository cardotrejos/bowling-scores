# frozen_string_literal: true

require_relative '../lib/file_handler'
require_relative '../lib/score'
require_relative '../lib/player'

RSpec.describe Score do
  Dir.chdir(File.dirname(__FILE__))

  describe 'The Class Score creates a proper Object' do
    test_score = Score.new({ player: Player.new('test_user') })
    it 'Creates a Score Logic Object' do
      expect(test_score).to be_a Score
    end
  end

  describe '#get_score' do
    file = FileHandler.new('./cases/ideal.txt', '.txt', FileValidations)
    data = file.organize_data
    player_name, score = data.first
    player = Player.new(player_name)
    score = Score.new({ player: Player.new(player), score: score })

    it 'It returns the perfect score' do
      expect(score.compute_score).to eql([30, 60, 90, 120, 150, 180, 210, 240, 270, 300])
    end

    it 'It returns a zero score' do
      file = FileHandler.new('./cases/input_zero.txt', '.txt', FileValidations)
      data = file.player_hash
      player_name, score = data.first
      player = Player.new(player_name)
      score = Score.new({ player: Player.new(player), score: score })

      expect(score.compute_score).to eql([0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    end

    it 'It returns a score' do
      file = FileHandler.new('./cases/test_input.txt', '.txt', FileValidations)
      data = file.player_hash
      player_name, score = data.first
      player = Player.new(player_name)
      score = Score.new({ player: Player.new(player), score: score })
      expect(score.compute_score).to eql([20, 39, 48, 66, 74, 84, 90, 120, 148, 167])
      expect(score.player.total_score).to eql(167)
    end
  end
end
