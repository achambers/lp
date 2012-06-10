current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

describe LonelyPlanet::BookingMatcher do
  before do
    file = File.read(DATA_DIR + '/accommodation.json')
    @accommodation_data = JSON.parse(file)

    file = File.read(DATA_DIR + '/travellers.json')
    @traveller_data = JSON.parse(file)
  end

  it 'should match travellers with an accommodation' do
    result = LonelyPlanet::BookingMatcher.match(@traveller_data, @accommodation_data)
    result[:travellers][1]['booking'].must_equal @accommodation_data[4]['id'] #=> Evan Pacocha was booked in to Pouros Campsite
    result[:accommodations][4]['guests'].must_include @traveller_data[1]['id'] #=> Pouros Campsite has had Evan Pacocha allocated as a guest
  end

end