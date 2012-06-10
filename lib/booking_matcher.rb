module LonelyPlanet
  class BookingMatcher
    class << self
      def match(travellers, accommodations)
        travellers.each do |traveller|
          accommodation = LonelyPlanet::Search.availability(accommodations, search_params(traveller))

          if accommodation
            link(traveller, accommodation)
          end
        end

        {:travellers => travellers, :accommodations => accommodations}
      end

      private

      def link(traveller, accommodation)
        traveller.booking = accommodation.id

        unless accommodation.guests
          accommodation.guests = []
        end

        accommodation.guests << traveller.id

        accommodation.free_capacity -= 1
      end

      def search_params(traveller)
        {
            :requirements => traveller.requirements,
            :price_min => traveller.min_price,
            :price_max => traveller.max_price
        }
      end
    end
  end
end