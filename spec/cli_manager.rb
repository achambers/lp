current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

describe LonelyPlanet::CliManager do
  describe 'the handling of the bin/lpbooker traveller call' do
    it 'should return a message when the traveller id is not known' do
      result = LonelyPlanet::CliManager.find_traveller('booked_travellers.json', 'booked_accommodation.json', 98789)

      result[:traveller].must_equal 'Traveller not found'
      result[:booking].must_be_nil
    end

    it 'should return a traveller that does have a booking' do
      result = LonelyPlanet::CliManager.find_traveller('booked_travellers.json', 'booked_accommodation.json', 12345)

      result[:traveller].must_equal 'Traveller: Julian Doherty'
      result[:booking].must_equal 'Booked at: Hotel Awesome'
    end

    it 'should return a traveller that does not have a booking' do
      result = LonelyPlanet::CliManager.find_traveller('booked_travellers.json', 'booked_accommodation.json', 1)

      result[:traveller].must_equal 'Traveller: Evan Pacocha'
      result[:booking].must_equal 'Not currently booked'
    end

    it 'should return a traveller that has an unknown accommodation id booked' do
      result = LonelyPlanet::CliManager.find_traveller('booked_travellers.json', 'booked_accommodation.json', 9)

      result[:traveller].must_equal 'Traveller: Wilson McClure'
      result[:booking].must_equal 'Unknown accommodation'
    end
  end

  describe 'the handling of the bin/lpbooker accommodation call' do
    it 'should return a message when the accommodation id is not known' do
      result = LonelyPlanet::CliManager.find_accommodation('booked_travellers.json', 'booked_accommodation.json', 1212)

      result[:accommodation].must_equal 'Accommodation not found'
      result[:guests].must_be_nil
    end

    it 'should return an accommodation that does have guests' do
      result = LonelyPlanet::CliManager.find_accommodation('booked_travellers.json', 'booked_accommodation.json', 4321)

      result[:accommodation].must_equal 'Accommodation: Hotel Awesome'
      result[:guests].must_include 'Julian Doherty'
      result[:guests].must_include 'Bob Frank'
    end

    it 'should return an accommodation that does not have any guests' do
      result = LonelyPlanet::CliManager.find_accommodation('booked_travellers.json', 'booked_accommodation.json', 171)

      result[:accommodation].must_equal 'Accommodation: Wisoky Campsite'
      result[:guests].must_equal 'Currently no bookings'
    end
  end

  describe 'the handling of the bin/lpbooker search call' do
    it 'should return a search result when an accommodation matches the search criteria' do
      result = LonelyPlanet::CliManager.find_availability('travellers.json', 'accommodation.json', 50, 200, ['internet', 'bath', 'phone'])

      result[:accommodation].must_equal 'Pouros Campsite, 66'
    end

    it 'should return a message when no accommodation matches the search criteria' do
      result = LonelyPlanet::CliManager.find_availability('travellers.json', 'accommodation.json', 150, 200, ['internet', 'bath', 'phone'])

      result[:accommodation].must_equal 'No available accommodation matches the criteria'
    end
  end
end