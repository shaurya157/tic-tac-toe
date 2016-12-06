require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)

  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    result = []
    board = @board.dup
    mark = nil
    @next_mover_mark == :x ? mark = :o : mark = :x

    @board.rows.each.with_index do |row, i|
      row.each.with_index do |_, j|
        if !@board[[i, j]]
          result << TicTacToeNode.new(board, mark, [i, j])
        end
      end
    end
    result
  end
end
