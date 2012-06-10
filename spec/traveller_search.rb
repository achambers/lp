current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

describe LonelyPlanet::TravellerSearch do
  before do
    file = File.read('dat/travellers.json')
    @traveller_data = JSON.parse(file)
  end

  it 'should return a traveller for a valid id' do
    traveller = LonelyPlanet::TravellerSearch.search(@traveller_data, 12345)

    traveller.wont_be_nil
    traveller['id'].must_equal 12345
    traveller['name'].must_equal 'Julian Doherty'
  end

  it 'should return nil for an invalid traveller id' do
    traveller = LonelyPlanet::TravellerSearch.search(@traveller_data, 9999)

    traveller.must_be_nil
  end
end