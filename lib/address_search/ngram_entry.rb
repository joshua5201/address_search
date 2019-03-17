require "json"
class AddressSearch::NgramEntry
  attr_reader :record, :ngram

  def self.load(raw_data)
    raw_data.map do |record|
      new(record)
    end
  end

  def self.load_json(filename)
    json_data = nil
    File.open(filename) do |f|
      json_data = JSON.load(f)
    end
    json_data.map do |record|
      new(JapanPostalCode::PostalArea.new(record["record"]), record["ngram"])
    end
  end

  def initialize(record, ngram = nil)
    @record = record
    if ngram.nil? 
      @ngram = AddressSearch::Ngram.new(@record.prefecture + @record.city + @record.area)
    else
      @ngram = AddressSearch::Ngram.new(ngram)
    end
  end

  def to_h
    { "record" => record.raw, "ngram" => ngram.to_a }
  end
end
