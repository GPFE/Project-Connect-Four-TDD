# frozen_string_literal: true

require_relative './lib/board'

game = Board.new
game.generate_board(5, 5)

ended = false

loop do
  game.player = 'x'
  game.play
  break if game.check_for_wictory != "continue"

  game.player = 'y'
  game.play
  break if game.check_for_wictory != "continue"
end