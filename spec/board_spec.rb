# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#generate_board' do
    subject(:empty_board) { described_class.new }
    context 'when 5, 5 given' do
      it "returns
      [
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, nil]
      ]" do
        expect(empty_board.generate_board(5, 5)).to eq(
          [
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil]
          ]
        )
      end
    end
    context 'when 4, 6 given' do
      it "returns
      [
        [nil, nil, nil, nil],
        [nil, nil, nil, nil],
        [nil, nil, nil, nil],
        [nil, nil, nil, nil],
        [nil, nil, nil, nil],
        [nil, nil, nil, nil]
      ]" do
        expect(empty_board.generate_board(4, 6)).to eq(
          [
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil],
            [nil, nil, nil, nil]
          ]
        )
      end
    end
  end

  describe '#set_position' do
    subject(:board_position) { described_class.new }
    context 'when 5 given with 5x5 board' do
      it 'modifies @table[4][4]' do
        board_position.instance_variable_set(:@table,
                                             [
                                               [nil, nil, nil, nil, nil],
                                               [nil, nil, nil, nil, nil],
                                               [nil, nil, nil, nil, nil],
                                               [nil, nil, nil, nil, nil],
                                               [nil, nil, nil, nil, nil]
                                             ])
        board_position.set_position(5)
        table = board_position.instance_variable_get(:@table)
        expect(table).to eq([
                              [nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, 'x']
                            ])
      end
    end

    context 'when 5 given with 5x5 board and [4][4] is occupied' do
      it 'modifies @table[3][4]' do
        board_position.instance_variable_set(:@table,
                                             [
                                               [nil, nil, nil, nil, nil],
                                               [nil, nil, nil, nil, nil],
                                               [nil, nil, nil, nil, nil],
                                               [nil, nil, nil, nil, nil],
                                               [nil, nil, nil, nil, 'x']
                                             ])
        board_position.set_position(5)
        table = board_position.instance_variable_get(:@table)
        expect(table).to eq([
                              [nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, nil],
                              [nil, nil, nil, nil, 'x'],
                              [nil, nil, nil, nil, 'x']
                            ])
      end
    end
  end

  describe '#make_displayable' do
    subject(:board_displayable) { described_class.new }
    context 'when player moves are {"x"=>[nil, nil, nil, nil, [0, 1, 3]]} on a 5x5 board' do
      it 'returns
        [
          ["|_|", "|_|", "|_|", "|_|", "|_|"],
          ["|_|", "|_|", "|_|", "|_|", "|_|"],
          ["|_|", "|_|", "|_|", "|_|", "|_|"],
          ["|_|", "|_|", "|_|", "|_|", "|_|"],
          ["|x|", "|x|", "|_|", "|x|", "|_|"]
        ]' do
        board_displayable.generate_board(5, 5)
        board_displayable.set_position(1)
        board_displayable.set_position(2)
        board_displayable.set_position(4)

        expect(board_displayable.make_displayable).to eq([
                                                           ['|_|', '|_|', '|_|', '|_|', '|_|'],
                                                           ['|_|', '|_|', '|_|', '|_|', '|_|'],
                                                           ['|_|', '|_|', '|_|', '|_|', '|_|'],
                                                           ['|_|', '|_|', '|_|', '|_|', '|_|'],
                                                           ['|x|', '|x|', '|_|', '|x|', '|_|']
                                                         ])
      end
    end

    context 'when player moves are {"x"=>[nil, [3], [2], [1], [0]], "y"=>[nil, nil, [3], [2, 3], [1, 2, 3]]} on a 5x5 board' do
      it 'returns
        [
          ["|_|", "|_|", "|_|", "|_|", "|_|"],
          ["|_|", "|_|", "|_|", "|x|", "|_|"],
          ["|_|", "|_|", "|x|", "|y|", "|_|"],
          ["|_|", "|x|", "|y|", "|y|", "|_|"],
          ["|x|", "|y|", "|y|", "|y|", "|_|"]
        ]' do
        board_displayable.generate_board(5, 5)
        board_displayable.set_position(1)
        board_displayable.player = 'y'
        board_displayable.set_position(2)
        board_displayable.player = 'x'
        board_displayable.set_position(2)
        board_displayable.player = 'y'
        board_displayable.set_position(3)
        board_displayable.set_position(3)
        board_displayable.player = 'x'
        board_displayable.set_position(3)
        board_displayable.player = 'y'
        board_displayable.set_position(4)
        board_displayable.set_position(4)
        board_displayable.set_position(4)
        board_displayable.player = 'x'
        board_displayable.set_position(4)

        expect(board_displayable.make_displayable).to eq([
                                                           ['|_|', '|_|', '|_|', '|_|', '|_|'],
                                                           ['|_|', '|_|', '|_|', '|x|', '|_|'],
                                                           ['|_|', '|_|', '|x|', '|y|', '|_|'],
                                                           ['|_|', '|x|', '|y|', '|y|', '|_|'],
                                                           ['|x|', '|y|', '|y|', '|y|', '|_|']
                                                         ])
      end
    end
  end

  describe '#check_for_wictory' do
    subject(:board_check) { described_class.new }
    context 'when row is occupied by a "x" player' do
      it 'returns winner' do
        instance_variable_set(:@player, 'x')
        board_check.instance_variable_set(:@player_moves, { 'x' => [nil, nil, nil, nil, [0, 1, 2, 3]] })

        expect(board_check.check_for_wictory).to eq('x wins')
      end
    end

    context 'when diagonal is occupied by a "x" player' do
      it 'returns winner' do
        instance_variable_set(:@player, 'x')
        board_check.instance_variable_set(:@player_moves,
                                          { 'x' => [nil, [3], [2], [1], [0]],
                                            'y' => [nil, nil, [3], [2, 3], [1, 2, 3]] })

        expect(board_check.check_for_wictory).to eq('x wins')
      end
    end
  end
end
