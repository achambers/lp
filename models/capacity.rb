class Capacity
  include DataMapper::Resource

  property :id, Serial
  property :total, Integer
  property :free, Integer
end