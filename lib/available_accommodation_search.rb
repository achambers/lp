module LonelyPlanet
  class AvailableAccommodationSearch
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