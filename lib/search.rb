module LonelyPlanet
  class Search
    class << self
      def search(data, id)
        data.detect {|entry| entry.id == id}
      end

      def availability(data, params)
        sorted_data = sort_by_price(data)

        sorted_data.detect do |accommodation|
          requirements_match?(params, accommodation) && price_match?(params, accommodation) && has_capacity?(accommodation)
        end
      end

      private

      def sort_by_price data
        data.clone.sort { |a, b| a.price <=> b.price }
      end

      def requirements_match?(params, accommodation)
        (params[:requirements] - accommodation.attributes).length == 0
      end

      def price_match?(params, accommodation)
        (accommodation.price >= params[:price_min]) && (accommodation.price <= params[:price_max])
      end

      def has_capacity?(accommodation)
        accommodation.free_capacity > 0
      end
    end
  end
end