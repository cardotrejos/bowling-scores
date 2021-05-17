# frozen_string_literal: true

require 'terminal-table'

# Table prints the table data of the game
class Table
  def initialize(data)
    @data = data
  end

  def table_output
    table = Terminal::Table.new do |c|
      c.add_row(['Frame', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      c.add_separator
      @data.each_key do |player|
        @data[player]
      end
    end
    puts table
  end
end
