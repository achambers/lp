current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)

require 'minitest/spec'
require 'minitest/autorun'
require 'spec_helper'
require 'json'

describe LonelyPlanet::Search do

  describe 'search for travellers' do

    before do
      @data = LonelyPlanet.to_travellers('travellers.json')
    end

    it 'should return a traveller for json file and a specific id' do
      traveller = LonelyPlanet::Search.search(@data, 12345)

      traveller.wont_be_nil
      traveller.id.must_equal 12345
      traveller.name.must_equal 'Julian Doherty'
    end

    it 'should return nil for json file and an invalid traveller id' do
      traveller = LonelyPlanet::Search.search(@data, 9999)

      traveller.must_be_nil
    end
  end

  describe 'search for accommodation' do

    before do
      @data = LonelyPlanet.to_accommodations('accommodation.json')
    end

    it 'should return an accommodation for a valid id' do
      accommodation = LonelyPlanet::Search.search(@data, 403)

      accommodation.wont_be_nil
      accommodation.id.must_equal 403
      accommodation.name.must_equal 'Dodgy Campsite'
    end

    it 'should return nil for an invalid accommodation id' do
      accommodation = LonelyPlanet::Search.search(@data, 9999)

      accommodation.must_be_nil
    end
  end

  describe 'search for available accommodation' do

    before do
      @accommodations = LonelyPlanet.to_accommodations('accommodation.json')
      @travellers = LonelyPlanet.to_travellers('travellers.json')
    end

    it 'should find an accommodation when traveller requirements and price match' do
      wilson = @travellers[2]

      search_params = {
          :requirements => wilson.requirements,
          :price_min => wilson.min_price,
          :price_max => wilson.max_price
      }

      accommodation = LonelyPlanet::Search.availability(@accommodations, search_params)

      accommodation.wont_be_nil
      accommodation.name.must_equal 'Little Backpackers'
    end

    it 'should find the cheapest accommodation that matches a travellers requirements, price range and has capacity' do
      evan = @travellers[1]

      search_params = {
          :requirements => evan.requirements,
          :price_min => evan.min_price,
          :price_max => evan.max_price
      }

      accommodation = LonelyPlanet::Search.availability(@accommodations, search_params)

      accommodation.wont_be_nil
      accommodation.name.must_equal 'Pouros Campsite'
    end

    it 'should not find an accommodation when a traveller requirements do not match' do
      julian = @travellers[0]

      search_params = {
          :requirements => julian.requirements
      }

      accommodation = LonelyPlanet::Search.availability(@accommodations, search_params)

      accommodation.must_be_nil
    end

    it 'should not find an accommodation when a travellers price range does not match' do
      bob = @travellers[3]

      search_params = {
          :requirements => bob.requirements,
          :price_min => bob.min_price,
          :price_max => bob.max_price
      }

      accommodation = LonelyPlanet::Search.availability(@accommodations, search_params)

      accommodation.must_be_nil
    end

    it 'should not find an accommodation if it does not have free capacity' do
      mark = @travellers[4]

      search_params = {
          :requirements => mark.requirements,
          :price_min => mark.min_price,
          :price_max => mark.max_price
      }

      accommodation = LonelyPlanet::Search.availability(@accommodations, search_params)

      accommodation.must_be_nil
    end
  end
end