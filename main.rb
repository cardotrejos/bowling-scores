# frozen_string_literal: true

require_relative 'lib/file_handler'
require_relative 'lib/score'
require_relative 'lib/player'
require_relative 'lib/table'

file = FileHandler.new(ARGV[0], '.txt', FileValidations)

# Print output

if file.validations.error
  puts file.validations.error
else
  puts Table.print_output(file.player_hash)
end
