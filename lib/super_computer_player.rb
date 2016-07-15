require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    tree = TicTacToeNode.new(game.board, mark)
    children = tree.children
    winners = children.select { |c| c.winning_node?(mark) }
    non_losers = children.reject { |c| c.losing_node?(mark) }
    (winners + non_losers).first.prev_move_pos
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
