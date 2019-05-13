require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(9).join(" ")
  end

  def score
    @answer = params[:word].upcase
    @letters = params[:letters].split
      if @answer.chars.all? { |letter| @answer.count(letter) <= @letters.count(letter) }
        if english_word?(@answer)
          @score = "Congratulations, #{@answer} is a valid word!"
        else
          @score = "Sorry, #{@answer} is not an english word"
        end
      else
        @score = "Sorry, #{@answer} can't be built out of #{@letters}"
      end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
