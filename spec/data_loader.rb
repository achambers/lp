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

  it 'should load an accommodation from json and save into the database' do
    LonelyPlanet::DataLoader.load(@accommodation_data)

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