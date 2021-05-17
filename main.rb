# frozen_string_literal: true

require_relative 'lib/file_handler'
require_relative 'lib/table'

file = FileHandler.new(ARGV[0], '.txt', FileValidations)

if file.validations.error
  puts file.validations.error
else
  table = Table.new(file.data)
  table.table_output
end
