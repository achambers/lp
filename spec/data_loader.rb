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

    @traveller_data = {
        "id" => 12345,
        "name" => "Julian Doherty",
        "priceRange" => {"min" => 120, "max" => 150},
        "requirements" => ["internet", "bath"]
    }
  end

  it 'should not load any accommodation data when it is nil' do
    LonelyPlanet::DataLoader.load(nil, nil)

    Accommodation.all.length.must_equal 0
  end

  it 'should load an accommodation from json and save it into the database' do
    LonelyPlanet::DataLoader.load(@accommodation_data, nil)

    Accommodation.all.length.must_equal 1

    accommodation = Accommodation.first

    accommodation.id.must_equal @accommodation_data['id']
    accommodation.name.must_equal @accommodation_data['name']
    accommodation.price.must_equal @accommodation_data['price']
    accommodation.attributez.length.must_equal @accommodation_data['attributes'].length
    accommodation.capacity.total.must_equal @accommodation_data['capacity']['total']
    accommodation.capacity.free.must_equal @accommodation_data['capacity']['free']
  end

  it 'should not load any traveller data when it is nil' do
    LonelyPlanet::DataLoader.load(nil, nil)

    Traveller.all.length.must_equal 0
  end

  it 'should load a traveller from json and save it into the database' do
    LonelyPlanet::DataLoader.load(nil, @traveller_data)

    Traveller.all.length.must_equal 1

    traveller = Traveller.first

    traveller.id.must_equal @traveller_data['id']
    traveller.name.must_equal @traveller_data['name']
    traveller.price_range.min.must_equal @traveller_data['priceRange']['min']
    traveller.price_range.max.must_equal @traveller_data['priceRange']['max']
    traveller.requirements.length.must_equal @traveller_data['requirements'].length
  end
end