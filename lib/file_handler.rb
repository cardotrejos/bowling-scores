# frozen_string_literal: true

# FileValidatotions check the file structure & also validates the structure
class FileValidations
  attr_reader :error

  def initialize(filename, extension)
    @filename = filename
    @extension = extension
    if extension_valid?
      file = File.open(filename)
      @lines = file.readlines.map(&:chomp)
    end
  rescue Errno::ENOENT
    @error = 'Check if file exists'
  rescue TypeError
    @error = 'Please, provide a valid file name'
  end

  def check_file
    return false unless extension_valid?
    return false unless @error.nil?
    return false unless structure_valid?

    true
  rescue TypeError
    @error = 'Please, check if the file name is correct'
  end

  private

  def structure_valid?
    result = true
    values = []
    @lines.each do |line|
      info = line.split(' ')
      result &&= info.length == 2
      result &&= info[0].split.all?(/[a-zA-Z]/)
      values.push(info[1])
    end
    result
  end

  def extension_valid?
    valid = File.extname(@filename) == @extension
    @error = 'Wrong file extension' unless valid
    valid
  rescue TypeError
    @error = 'Please, check if the file name is correct'
  end
end

# FileReader proccess the score file if correct, and stores the player names and scores in a Hash
class FileHandler
  attr_reader :data, :validations, :player_hash

  def initialize(filename, extension, validations)
    @player_hash = {}
    @filename = filename
    @validations = validations.new(filename, extension)
    organize_data if @validations.check_file
  end

  def organize_data
    file = File.read(@filename)
    @player_hash = get_players(file)

    split_data(file).each do |turn|
      player_name = turn[:player_name]
      score = turn[:score] == 'F' ? 'F' : turn[:score].to_i

      number_turn = @player_hash[player_name].size
      current_turn = "turn: #{number_turn}".to_sym
      next_turn = "turn: #{number_turn + 1}".to_sym

      if number_turn.zero? || @player_hash[player_name][current_turn][:turn_b]
        @player_hash[player_name][next_turn] = { turn_a: score }
        @player_hash[player_name][next_turn][:turn_b] = 0 if score == 10 && number_turn != 10
      else
        @player_hash[player_name][current_turn][:turn_b] = score
      end
    end

    @player_hash
  end

  private

  def split_data(data)
    data.split("\n").map do |el|
      turn = el.split(' ')
      { player_name: turn[0], score: turn[1] }
    end
  end

  def get_players(data)
    player_hash = {}
    split_data(data).each do |turn|
      player_name = turn[:player_name]
      player_hash[player_name] = {} unless player_hash[player_name]
    end

    player_hash
  end
end
