class Traveller
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has 1, :price_range

  has n, :requirements, 'Attribute', :through => Resource

  def initialize(attrs, &block)
    super(:id => attrs['id'], :name => attrs['name'], &block)
  end
end