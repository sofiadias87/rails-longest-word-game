require "open-uri"

class GamesController < ApplicationController

  def new
    @letters=[]
    10. times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @word = params[:play]
    @letters = params[:letters].split

    @response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    @response = JSON.parse(@response.read) #chamar 


    @word_in_grid = @word.chars.all? do |char|
      @word.count(char) <= @letters.count(char)
    end

    if @word_in_grid # score
      if @response["found"]
        @score  = "Valid English Word"
      else
        @score = "Not a Valid English Word"
      end
    else
      @score = "Letters not in the grid"
    end
  end
end
