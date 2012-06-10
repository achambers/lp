module LonelyPlanet
  class AccommodationSearch
    class << self
      def search(data, id)
        data.detect {|accommodation| accommodation['id'] == id}
      end
    end
  end
end