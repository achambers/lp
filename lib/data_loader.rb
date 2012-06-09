module LonelyPlanet
  class DataLoader
    class << self
      def load(accommodation_data, traveller_data)
        if accommodation_data
          accommodation = Accommodation.new(accommodation_data)
          accommodation.attributez = attributes(accommodation_data['attributes'])
          accommodation.capacity = accommodation_capacity(accommodation_data['capacity'])
          accommodation.save
        end

        if traveller_data
          traveller = Traveller.new(traveller_data)
          traveller.price_range = traveller_price_range(traveller_data['priceRange'])
          traveller.requirements = attributes(traveller_data['requirements'])
          traveller.save
        end
      end

      private

      def attributes data
        attributes = []
        data.each do |entry|
          attribute = Attribute.first(:name => entry) || Attribute.create(:name => entry)
          attributes << attribute
        end

        attributes
      end

      def accommodation_capacity data
        Capacity.create(:total => data['total'], :free => data['free'])
      end

      def traveller_price_range data
        PriceRange.create(:min => data['min'], :max => data['max'])
      end
    end
  end
end