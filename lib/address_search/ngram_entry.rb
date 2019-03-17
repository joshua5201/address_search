class AddressSearch::NgramEntry
  attr_reader :record, :ngram

  def self.load(raw_data)
    raw_data.map do |record|
      new(record)
    end
  end

  def initialize(record)
    @record = record
    @ngram = AddressSearch::Ngram.new(@record.prefecture + @record.city + @record.area)
  end
end
