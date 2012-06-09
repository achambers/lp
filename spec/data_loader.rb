current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

describe LonelyPlanet::DataLoader do
  before do
    DataMapper.auto_migrate!

    file = File.read('dat/accommodation_sample.json')
    @accommodation_data = JSON.parse(file)

    file = File.read('dat/traveller_sample.json')
    @traveller_data = JSON.parse(file)
  end

  it 'should not load any accommodation data when it is nil' do
    LonelyPlanet::DataLoader.load(nil, nil)

    Accommodation.all.length.must_equal 0
  end

  it 'should load an accommodation from json and save it into the database' do
    LonelyPlanet::DataLoader.load(@accommodation_data, nil)

    Accommodation.all.length.must_equal 1

    accommodation = Accommodation.first

    accommodation.to_json.must_equal @accommodation_data
  end

  it 'should not load any traveller data when it is nil' do
    LonelyPlanet::DataLoader.load(nil, nil)

    Traveller.all.length.must_equal 0
  end

  it 'should load a traveller from json and save it into the database' do
    LonelyPlanet::DataLoader.load(nil, @traveller_data)

    Traveller.all.length.must_equal 1

    traveller = Traveller.first

    traveller.to_json.must_equal @traveller_data
  end
end