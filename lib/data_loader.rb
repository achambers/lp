module LonelyPlanet
  class DataLoader
    class << self
      def load(accommodation_data, traveller_data)
        if accommodation_data
          accommodation = Accommodation.new(accommodation_data)
          accommodation.attributez = accommodation_attributez(accommodation_data)
          accommodation.capacity = accommodation_capacity(accommodation_data)
          accommodation.save
        end

        if traveller_data
          traveller = Traveller.new(traveller_data)
          traveller.price_range = traveller_price_range(traveller_data)
          traveller.requirements = traveller_requirements(traveller_data)
          traveller.save
        end
      end

      private

      def accommodation_attributez attrs
        attributes = []
        attrs['attributes'].each do |attribute_string|
          attribute = Attribute.first(:name => attribute_string) || Attribute.create(:name => attribute_string)
          attributes << attribute
        end

        attributes
      end

      def accommodation_capacity attrs
        Capacity.create(:total => attrs['capacity']['total'], :free => attrs['capacity']['free'])
      end

      def traveller_price_range attrs
        PriceRange.create(:min => attrs['priceRange']['min'], :max => attrs['priceRange']['max'])
      end

      def traveller_requirements attrs
        requirements = []
        attrs['requirements'].each do |requirements_string|
          attribute = Attribute.first(:name => requirements_string) || Attribute.create(:name => requirements_string)
          requirements << attribute
        end

        requirements
      end
    end
  end
end