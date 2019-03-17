class AddressSearch::Ngram
  attr_reader :tokens, :map

  class Token
    attr_reader :word, :count

    def initialize(word)
      @word = word
      @count = 1;
    end
    
    def inc(c = 1)
      @count += 1;
    end
  end

  def initialize(text, max_n = 2)
    @tokens = []
    @map = {}
    for n in (1..max_n) 
      calculate(text, n)
    end
  end

  def calculate(text, n)
    for s in (0..(text.length - n))
      word = text.slice(s, n)
      if map.has_key?(word) 
        map[word].inc
      else
        token = Token.new(word)
        map[word] = token
        tokens << token
      end
    end
  end

  def inner_product(other)
    tokens.reduce(0) do |product, token|
      if other.map.has_key?(token.word)
        product + token.count * other.map[token.word].count
      else
        product
      end
    end
  end
end
