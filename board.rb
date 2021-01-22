#!/usr/bin/env ruby

# Prints out the inputted info in a pleasing way.
class Board
  require "colorize"

  def initialize(guess)
    @guess = guess
  end

  def update(guess, pegs)
    @guess = guess
    @pegs = pegs
  end

  def print_board(colors = @guess)
    puts "Your guess:".black.on_white
    print_guess(colors)
    print_pegs
    puts "\n"
    puts "The board's palette:".white.on_black
    print_guess(colors)
  end

  def print_guess(palette)
    colors = palette.map(&:to_sym)
    palette.each_with_index do |color, index|
      print color.colorize(:color => :black, :background => colors[index]).to_s
    end
  end

  def print_pegs
    print "Peg".white.on_black * @pegs[:black]
    print "Peg".black.on_white * @pegs[:white]
  end
end
