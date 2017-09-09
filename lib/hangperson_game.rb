class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :guesses, :wrong_guesses, :word
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess(letter)
    if (not letter =~ /[[:alpha:]]/) or letter.empty? or letter == nil
      raise ArgumentError
    else 
      letter.downcase!
      if @word.include? letter and !@guesses.include? letter
        @guesses += letter
        return true
      elsif !@word.include? letter and !@wrong_guesses.include? letter
        @wrong_guesses += letter
        return true
      else
        return false
      end
    end
  end
  
  def word_with_guesses
    result = ""
    for i in @word.each_char
      if @guesses.include? i
        result += i
      else
        result += "-"
      end
    end
    return result
  end
  
  def check_win_or_lose
    if @word == word_with_guesses
      return :win
    elsif @wrong_guesses.length == 7
      return :lose
    else
      return :play
    end
  end
    
end
