require "japan_postal_code"
require "address_search/ngram"
require "address_search/ngram_entry"

class AddressSearch
  attr_reader :dataset, :filename
  def initialize(filename)
    @filename = filename
    @finder = JapanPostalCode::AddressFinder.new(filename: filename)
    @dataset = NgramEntry.load(@finder.dump.values.flatten)
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
end
