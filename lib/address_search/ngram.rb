class AddressSearch::Ngram
  attr_reader :tokens, :map, :max_n

  class Token
    attr_reader :word, :count

    def initialize(word, count = 1)
      @word = word
      @count = count;
    end
    
    def inc(c = 1)
      @count += 1;
    end

    def to_h
      {"word" => word, "count" => count}
    end
  end

  def initialize(text_or_array, max_n = 2)
    @max_n = max_n
    if text_or_array.is_a? Array
      @tokens = text_or_array.map {|h| Token.new(h["word"], h["count"]) }
      @map = @tokens.map { |token|
        [token.word, token]
      }.to_h
      return
    end
    text = text_or_array
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

  def to_a
    tokens.map(&:to_h)
  end
end
