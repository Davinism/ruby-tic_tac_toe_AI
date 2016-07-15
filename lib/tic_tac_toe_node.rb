require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return board.winner == opponent(evaluator) if board.over?

    if evaluator == next_mover_mark
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return board.winner == evaluator if board.over?

    if evaluator == next_mover_mark
      children.any? { |child| child.winning_node?(evaluator) }
    else
      children.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    board.empty_squares.map do |empty_square|
      new_board = board.clone
      new_board[empty_square] = next_mover_mark
      new_next_mover = opponent(next_mover_mark)
      TicTacToeNode.new(new_board, new_next_mover, empty_square)
    end
  end

  private

  def opponent(evaluator)
    evaluator == :x ? :o : :x
  end
end

class Board
  def empty_squares
    results_arr = []
    rows.each_with_index do |row, idx|
      row.each_with_index do |square, jdx|
        results_arr << [idx, jdx] if square.nil?
      end
    end
    results_arr
  end

  def clone
    new_board = Board.new
    (0..2).each do |idx|
      (0..2).each  do |jdx|
        new_board[[idx, jdx]] = self[[idx, jdx]]
      end
    end
    new_board
  end
end
