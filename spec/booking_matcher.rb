current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

module LonelyPlanet
  class BookingMatcher
    class << self
      def load(travellers, accommodations)
        travellers.each do |traveller|
          matched_accommodation = LonelyPlanet::Search.availability(accommodations, search_params(traveller))

          if matched_accommodation
            traveller['booking'] = matched_accommodation['id']

            unless matched_accommodation['guests']
              matched_accommodation['guests'] = []
            end

            matched_accommodation['guests'] << traveller['id']

            matched_accommodation['capacity']['free'] -= 1
          end
        end

        {:travellers => travellers, :accommodations => accommodations}
      end

      private

      def search_params traveller
        {
            :requirements => traveller['requirements'],
            :price_min => traveller['priceRange']['min'],
            :price_max => traveller['priceRange']['max']
        }
      end
    end
  end
end

describe LonelyPlanet::BookingMatcher do
  before do
    file = File.read(File.dirname(__FILE__) + '/data/accommodation.json')
    @accommodation_data = JSON.parse(file)

    file = File.read(File.dirname(__FILE__) + '/data/travellers.json')
    @traveller_data = JSON.parse(file)
  end

  it 'should match travellers with an accommodation' do
    result = LonelyPlanet::BookingMatcher.load(@traveller_data, @accommodation_data)
    result[:travellers][1]['booking'].must_equal @accommodation_data[4]['id'] #=> Evan Pacocha was booked in to Pouros Campsite
    result[:accommodations][4]['guests'].must_include @traveller_data[1]['id'] #=> Pouros Campsite has had Evan Pacocha allocated as a guest
  end

end