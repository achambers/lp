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
        match = data.detect do |accommodation|
          (params[:requirements] - accommodation['attributes']).length == 0
        end
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
    wilson = @traveller_data[2]

    search_params = {
        :requirements => wilson['requirements']
    }

    accommodation = LonelyPlanet::AccommodationSearch.search_accommodation(@accommodation_data, search_params)

    accommodation.wont_be_nil
    accommodation['name'].must_equal 'Little Backpackers'
  end
end