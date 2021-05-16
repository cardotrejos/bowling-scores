# frozen_string_literal: true

require_relative 'lib/file_handler'

file = FileHandler.new(ARGV[0], '.txt', FileValidations)

if file.validations.error
  puts file.validations.error
else
  puts file.data
end
