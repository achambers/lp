current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

describe LonelyPlanet::AccommodationSearch do
  before do
    file = File.read(File.dirname(__FILE__) + '/dat/accommodation.json')
    @accommodation_data = JSON.parse(file)
  end

  it 'should return an accommodation for a valid id' do
    accommodation = LonelyPlanet::AccommodationSearch.search(@accommodation_data, 403)

    accommodation.wont_be_nil
    accommodation['id'].must_equal 403
    accommodation['name'].must_equal 'Dodgy Campsite'
  end

  it 'should return nil for an invalid accommodation id' do
    accommodation = LonelyPlanet::AccommodationSearch.search(@accommodation_data, 9999)

    accommodation.must_be_nil
  end
end