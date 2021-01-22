#!/usr/bin/env ruby

require "./game_objects.rb"
require "./board.rb"

# Generates values and sets the rounds
class Game
  include Masterminds

  def initialize(colors, pegs, limit)
    @colors = colors
    @pegs = pegs
    @breaker = CodeBreaker.new(colors, pegs)
    @maker = CodeMaker.new(colors, pegs)
    @board = Board.new(nil)
    @limit = limit
  end

  def play
    rounds = 0
    until rounds == @limit
      @board.print_guess(@colors)
      guess = @breaker.guess
      break if @maker.win?(guess)

      pegs = @maker.compare(guess) # Not quite a win

      @board.update(guess, pegs)
      @board.print_board
    end

    "You lose" if rounds == @limit
    end
  end
end

# Creating Game
colors = %w[red magenta blue yellow green cyan]

mastermind = Game.new(colors, 4, 9)
mastermind.play
