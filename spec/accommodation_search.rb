current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

module LonelyPlanet
  class AccommodationSearch
    class << self
      def search_accommodation(data, params)
        data.sort! { |a, b| a['price'] <=> b['price'] }

        match = data.detect do |accommodation|
          requirements_match?(params, accommodation) && price_match?(params, accommodation) && has_capacity?(accommodation)
        end
      end

      private
      def requirements_match?(params, accommodation)
        (params[:requirements] - accommodation['attributes']).length == 0
      end

      def price_match?(params, accommodation)
        (accommodation['price'] >= params[:price_min]) && (accommodation['price'] <= params[:price_max])
      end

      def has_capacity?(accommodation)
        accommodation['capacity']['free'] > 0
      end
    end
  end
end

describe LonelyPlanet::AccommodationSearch do
  before do
    file = File.read('dat/accommodation.json')
    @accommodation_data = JSON.parse(file)

    file = File.read('dat/travellers.json')
    @traveller_data = JSON.parse(file)
  end

  it 'should find an accommodation when traveller requirements and price match' do
    wilson = @traveller_data[2]

    search_params = {
        :requirements => wilson['requirements'],
        :price_min => wilson['priceRange']['min'],
        :price_max => wilson['priceRange']['max']
    }

    accommodation = LonelyPlanet::AccommodationSearch.search_accommodation(@accommodation_data, search_params)

    accommodation.wont_be_nil
    accommodation['name'].must_equal 'Little Backpackers'
  end

  it 'should find the cheapest accommodation that matches a travellers requirements, price range and has capacity' do
    evan = @traveller_data[1]

    search_params = {
        :requirements => evan['requirements'],
        :price_min => evan['priceRange']['min'],
        :price_max => evan['priceRange']['max']
    }

    accommodation = LonelyPlanet::AccommodationSearch.search_accommodation(@accommodation_data, search_params)

    accommodation.wont_be_nil
    accommodation['name'].must_equal 'Pouros Campsite'
  end

  it 'should not find an accommodation when a traveller requirements do not match' do
    julian = @traveller_data[0]

    search_params = {
        :requirements => julian['requirements']
    }

    accommodation = LonelyPlanet::AccommodationSearch.search_accommodation(@accommodation_data, search_params)

    accommodation.must_be_nil
  end

  it 'should not find an accommodation when a travellers price range does not match' do
    bob = @traveller_data[3]

    search_params = {
        :requirements => bob['requirements'],
        :price_min => bob['priceRange']['min'],
        :price_max => bob['priceRange']['max']
    }

    accommodation = LonelyPlanet::AccommodationSearch.search_accommodation(@accommodation_data, search_params)

    accommodation.must_be_nil
  end

  it 'should not find an accommodation if it does not have free capacity' do
    mark = @traveller_data[4]

    search_params = {
        :requirements => mark['requirements'],
        :price_min => mark['priceRange']['min'],
        :price_max => mark['priceRange']['max']
    }

    accommodation = LonelyPlanet::AccommodationSearch.search_accommodation(@accommodation_data, search_params)

    accommodation.must_be_nil
  end
end