module LonelyPlanet
  class TravellerSearch
    class << self
      def search(data, id)
        data.detect {|traveller| traveller['id'] == id}
      end
    end
  end
end