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
  attr_reader :data, :validations

  def initialize(filename, extension, validations)
    @data = {}
    @filename = filename
    @validations = validations.new(filename, extension)
    process_output if @validations.check_file
  end

  private

  def process_output
    file = File.open(@filename)
    @lines = file.readlines.map(&:chomp)

    @lines.each do |line|
      player_throw = line.split(' ')
      if @data[player_throw[0]]
        @data[player_throw[0]].push(player_throw[1])
      else
        @data[player_throw[0]] = [player_throw[1]]
      end
    end
  end
end
