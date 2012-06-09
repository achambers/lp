current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'

describe LonelyPlanet::DataLoader do
  before do
    DataMapper.auto_migrate!

    @accommodation_data = {
        "id" => 4321,
        "name" => "Hotel Awesome",
        "price" => 130,
        "attributes" => ["close to transport", "internet", "bath"],
        "capacity" => {"total" => 25, "free" => 12}
    }
  end

  it 'should load an accommodation into the database' do
    load(@accommodation_data)

    Accommodation.all.length.must_equal 1

    accommodation = Accommodation.first

    accommodation.id.must_equal @accommodation_data['id']
    accommodation.name.must_equal @accommodation_data['name']
    accommodation.price.must_equal @accommodation_data['price']
    accommodation.attributez.length.must_equal @accommodation_data['attributes'].length
    accommodation.capacity.total.must_equal @accommodation_data['capacity']['total']
    accommodation.capacity.free.must_equal @accommodation_data['capacity']['free']
  end
end

def load(attrs)
  accommodation = Accommodation.new(attrs)
  accommodation.attributez = accommodation_attributez(attrs)
  accommodation.capacity = accommodation_capacity(attrs)

  accommodation.save
end

def accommodation_attributez attrs
  attributes = []
  attrs['attributes'].each do |attribute_string|
    attribute = Attribute.first(:name => attribute_string) || Attribute.create(:name => attribute_string)
    attributes << attribute
  end

  attributes
end

def accommodation_capacity attrs
  Capacity.create(:total => attrs['capacity']['total'], :free => attrs['capacity']['free'])
end