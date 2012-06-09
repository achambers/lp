module LonelyPlanet
  class DataLoader
    class << self
      def load(attrs)
        accommodation = Accommodation.new(attrs)
        accommodation.attributez = accommodation_attributez(attrs)
        accommodation.capacity = accommodation_capacity(attrs)

        accommodation.save
      end

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
    end
  end
end