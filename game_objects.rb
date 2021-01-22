#!/usr/bin/env ruby

module Masterminds
  # Create the secret code for the game.
  class CodeMaker
    def initialize(colors, pegs, controller = nil)
      @code = generate_code(colors, pegs, controller)
    end

    private

    def generate_code(colors, pegs, controller = nil)
      if controller == "human"
        index = gets.chomp.split("")
        colors[index]
      else
        colors.sample(pegs) # CPU
      end
    end

    def colors_right(guess)
      correct = 0
      @code.each do |color|
        correct += 1 if guess.any?(color)
      end
      correct
    end

    def places_right(guess)
      correct = 0
      @code.each_with_index do |color, place|
        correct += 1 if color == guess[place]
      end
      correct
    end

    public

    def win?(guess)
      if guess == @code
        puts "Your guess was correct, mastermind."
        return true
      else
        puts "keep going"
      end
    end

    # keep data internal and only return responses
    def compare(guess)
      return true if win?(guess)

      white_pegs = places_right(guess) # place & color is right
      black_pegs = colors_right(guess) - white_pegs # Remove redundant pegs
      {
        black: black_pegs,
        white: white_pegs,
      }
    end
  end

  # Simply takes input for the guess, by cpu or pc.
  class CodeBreaker
    def initialize(colors, pegs)
      @colors = colors
      @pegs = pegs
    end

    def guess
      # No repeat colors

      color_index = gets.chomp.split("")
      color_index.map!(&:to_i) # Insert the ordered index
      color_count = color_index.each.map { |color| color_index.count(color) }
      # TODO: add exception for repeat values, repeat def
      "Invalid" if color_count.any? { |color| color > 1 }
      color_index.each.map { |index| @colors[index] }
    end
  end
end
