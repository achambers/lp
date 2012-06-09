class Traveller
  include DataMapper::Resource

  property :id, Serial
  property :name, String

  has 1, :price_range

  has n, :requirements, 'Attribute', :through => Resource

  def initialize(attrs, &block)
    super(:id => attrs['id'], :name => attrs['name'], &block)
  end

  def to_json
    array = []
    requirements.each do |requirement|
      array << requirement.name
    end

    {
        'id' => id,
        'name' => name,
        'priceRange' => {'min' => price_range.min, 'max' => price_range.max},
        'requirements' => array
    }
  end
end