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
        data.sort! {|a,b| a['price'] <=> b['price']}

        match = data.detect do |accommodation|
          requirements_match?(params, accommodation) &&
              price_match?(params, accommodation)
        end
      end

      private
      def requirements_match?(params, accommodation)
        (params[:requirements] - accommodation['attributes']).length == 0
      end

      def price_match?(params, accommodation)
        (accommodation['price'] >= params[:price_min]) && (accommodation['price'] <= params[:price_max])
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
    accommodation['name'].must_equal 'Little Backpackers The Second'
  end

  it 'should not find an accommodation when a traveller requirements do not match' do
    julian = @traveller_data[0]

    search_params = {
        :requirements => julian['requirements']
    }

    accommodation = LonelyPlanet::AccommodationSearch.search_accommodation(@accommodation_data, search_params)

    accommodation.must_be_nil
  end
end