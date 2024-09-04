# frozen_string_literal: true

class Board
  attr_reader :table
  attr_writer :player

  def initialize
    @table = nil
    @player = 'x'
    @player_moves = {}
    @displayable_table = []
  end

  def generate_board(x, y)
    @table = Array.new(y) { Array.new(x) }
  end

  def set_position(position)
    position -= 1
    empty_row = find_empty_row(position)
    @table[empty_row][position] = @player

    @player_moves[@player] = [] if @player_moves[@player].nil?
    @player_moves[@player][empty_row] = [] if @player_moves[@player][empty_row].nil?
    @player_moves[@player][empty_row] << position
    p @player_moves
  end

  def find_empty_row(position)
    index = @table.size - 1
    index -= 1 until @table[index][position].nil?
    index
  end

  def is_occupied(place)
    place == @player
  end

  def check_for_wictory
    counter = 1

    @player_moves[@player].each do |move|
      next unless move.is_a?(Array)

      move.sort.reduce do |prev, move|
        break if counter >= 4

        move == prev + 1 ? counter += 1 : counter = 1
        move
      end
    end
    return "#{@player} wins" if counter >= 4

    counter = 1

    moves = []
    @player_moves[@player].each do |move|

      next unless move.is_a?(Array)

      moves << move
    end

    moves.push([-1])
    rows_elements = []

    moves.each_with_index do |arr, idx|
      next if arr.nil?
      arr.each do |element|
        next if moves[idx + 1].nil?
        moves[idx + 1].each do |next_element|
        if element == next_element + 1
          rows_elements << element
          break
        end
        end
      end
    end
    counter = 1

    rows_elements.sort.reduce do |prev, move|
      break if counter >= 4
      move == prev + 1 ? counter += 1 : counter = 1
      move
    end
    return "#{@player} wins" if counter >= 4

    moves.each_with_index do |arr, idx|
      next if arr.nil?
      arr.each do |element|
        next if moves[idx - 1].nil?
        moves[idx - 1].each do |next_element|
        if element == next_element + 1
          rows_elements << element
          break
        end
        end
      end
    end

    counter = 1

    rows_elements.sort { |a, b| a - b}.reduce do |prev, move|
      break if counter >= 4
      move == prev + 1 ? counter += 1 : counter = 1
      move
    end
    return "#{@player} wins" if counter >= 4

    rows_elements.clear
    p moves

    moves.each_with_index do |arr, idx|
      next if arr.nil?
      arr.each do |element|
        next if moves[idx - 1].nil?
        moves[idx - 1].each do |next_element|
        if element == next_element
          rows_elements << element
          break
        end
        end
      end
    end
    counter = 2

    rows_elements.sort { |a, b| a - b}.reduce do |prev, move|
      break if counter >= 4
      move == prev ? counter += 1 : counter = 1
      move
    end
    return "#{@player} wins" if counter >= 4
    "continue"
  end

  def make_displayable
    @displayable_table = []
    @table.each_with_index do |arr, idx|
      @displayable_table << []
      arr.each_with_index do |element, _super_idx|
        value = element.nil? ? '|_|' : "|#{element}|"
        @displayable_table[idx] << value
      end
    end
    @displayable_table
  end

  def display
    make_displayable

    @displayable_table.each do |line|
      puts line.join(' ')
    end
  end

  def play
    puts "It's player's #{@player} turn"
    position = gets.chomp.to_i
    set_position(position)
    display
  end
end