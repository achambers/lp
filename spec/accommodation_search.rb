current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

module LonelyPlanet
  class AccommodationSearch
    class << self
      def search params

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

  it 'should find an accommodation when traveller requirements match' do
    julian = @traveller_data[0]

    search_params = {
        :requirements => julian['requirements']
    }

    accommodation = LonelyPlanet::AccommodationSearch.search(search_params)

    accommodation.wont_be_nil
  end
end