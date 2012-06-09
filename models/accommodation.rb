class Accommodation
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :price, Integer

  has n, :attributez, 'Attribute', :through => Resource #only calling property attributez as 'attributes'' it is a reserved DataMapper word

  has 1, :capacity

  def initialize(attrs, &block)
    super(:id => attrs['id'], :name => attrs['name'], :price => attrs['price'], &block)
  end
end