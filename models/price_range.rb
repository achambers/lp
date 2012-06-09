class PriceRange
  include DataMapper::Resource

  property :id, Serial
  property :min, Integer
  property :max, Integer
end