current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

describe LonelyPlanet::CliManager do
  describe 'the handling of the bin/lpbooker traveller call' do
    it 'should return a message when the traveller id is not known' do
      result = LonelyPlanet::CliManager.find_traveller(SPEC_ROOT + '/data/booked_travellers.json', SPEC_ROOT + '/data/booked_accommodation.json', 98789)

      result[:traveller].must_equal 'Traveller not found'
      result[:booking].must_be_nil
    end

    it 'should return a traveller that does have a booking' do
      result = LonelyPlanet::CliManager.find_traveller(SPEC_ROOT + '/data/booked_travellers.json', SPEC_ROOT + '/data/booked_accommodation.json', 12345)

      result[:traveller].must_equal 'Traveller: Julian Doherty'
      result[:booking].must_equal 'Booked at: Hotel Awesome'
    end

    it 'should return a traveller that does not have a booking' do
      result = LonelyPlanet::CliManager.find_traveller(SPEC_ROOT + '/data/booked_travellers.json', SPEC_ROOT + '/data/booked_accommodation.json', 1)

      result[:traveller].must_equal 'Traveller: Evan Pacocha'
      result[:booking].must_equal 'Not currently booked'
    end

    it 'should return a traveller that has an unknown accommodation id booked' do
      result = LonelyPlanet::CliManager.find_traveller(SPEC_ROOT + '/data/booked_travellers.json', SPEC_ROOT + '/data/booked_accommodation.json', 9)

      result[:traveller].must_equal 'Traveller: Wilson McClure'
      result[:booking].must_equal 'Unknown accommodation'
    end
  end
end