current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

describe LonelyPlanet::BookingMatcher do
  before do
    @accommodations = LonelyPlanet.to_accommodations('accommodation.json')
    @travellers = LonelyPlanet.to_travellers('travellers.json')
  end

  it 'should match travellers with an accommodation' do
    result = LonelyPlanet::BookingMatcher.match(@travellers, @accommodations)
    result[:travellers][1].booking.must_equal @accommodations[4].id #=> Evan Pacocha was booked in to Pouros Campsite
    result[:accommodations][4].guests.must_include @travellers[1].id #=> Pouros Campsite has had Evan Pacocha allocated as a guest
  end

end