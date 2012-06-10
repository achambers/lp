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