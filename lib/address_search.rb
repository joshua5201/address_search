require "japan_postal_code"
require "address_search/ngram"
require "address_search/ngram_entry"

class AddressSearch
  attr_reader :dataset, :filename
  def initialize(filename, format = :csv)
    @filename = filename
    if format == :csv
      finder = JapanPostalCode::AddressFinder.new(filename: filename)
      @dataset = NgramEntry.load(finder.dump.values.flatten)
    elsif format == :json
      @dataset = NgramEntry.load_json(filename)
    else 
      raise ArgumentError.new("Unknown format #{format}")
    end
  end

  def inspect
    "#<AddressSearch filename: #{@filename}>"
  end

  class NgramMatch
    attr_accessor :entry, :product
    def initialize(entry, product)
      @entry, @product = entry, product
    end
  end

  def perform(keyword)
    find_matches(keyword).map do |match|
      match.entry.record.raw
    end
  end

  def find_matches(keyword)
    matches = []
    ngram = Ngram.new(keyword)
    dataset.each do |entry|
      product = ngram.inner_product(entry.ngram)
      if product > 0
        matches << NgramMatch.new(entry, product)
      end
    end
    matches.sort { |x, y| y.product <=> x.product }
  end

  def to_a
    dataset.map(&:to_h)
  end
end
