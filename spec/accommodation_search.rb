current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

describe LonelyPlanet::AccommodationSearch do
  before do
    file = File.read('dat/accommodation.json')
    @accommodation_data = JSON.parse(file)

    file = File.read('dat/travellers.json')
    @traveller_data = JSON.parse(file)
  end

  it 'should not find an accommodation when traveller requirements do not match' do
    julian = @traveller_data[0]

    puts julian
  end
end