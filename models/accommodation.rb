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

  def to_json
    array = []
    attributez.each do |attribute|
      array << attribute.name
    end

    {
        'id' => id,
        'name' => name,
        'price' => price,
        'attributes' => array,
        'capacity' => {'total' => capacity.total, 'free' => capacity.free}
    }
  end
end