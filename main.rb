# frozen_string_literal: true

require_relative './lib/board'

game = Board.new
game.generate_board(5, 5)

game.set_position(1)
game.player = 'y'
game.set_position(2)
game.player = 'x'
game.set_position(2)
game.player = 'y'
game.set_position(3)
game.set_position(3)
game.player = 'x'
game.set_position(3)
game.player = 'y'
game.set_position(4)
game.set_position(4)
game.set_position(4)
game.player = 'x'
game.set_position(4)

game.display
