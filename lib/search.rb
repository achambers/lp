module LonelyPlanet
  class Search
    class << self
      def search(data, id)
        data.detect {|entry| entry['id'] == id}
      end

      def availability(data, params)
        sorted_data = data.clone.sort { |a, b| a['price'] <=> b['price'] }

        match = sorted_data.detect do |accommodation|
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