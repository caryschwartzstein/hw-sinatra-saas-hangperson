class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter)
    if !(letter =~ /[A-Za-z]/)
      raise ArgumentError
    elsif (@guesses + @wrong_guesses).include?(letter.upcase) || 
      (@guesses + @wrong_guesses).include?(letter.downcase)
      return false
    end
    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    return true
  end
  
  def word_with_guesses
    to_return = ''
    @word.each_char do |letter|
      if @guesses.include?(letter)
        to_return += letter
      else
        to_return += '-'
      end
    end
    to_return
  end
  
  def check_win_or_lose
    if self.word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
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

end
