module LonelyPlanet
  class CliManager
    class << self
      def find_traveller(travellers_file, accommodations_file, id)
        traveller_data = JSON.parse(File.read(travellers_file))

        traveller = traveller_data.detect {|data| data['id'] == id}

        return {:traveller => 'Traveller not found'} unless traveller

        result = {:traveller => "Traveller: #{traveller['name']}"}

        if traveller['booking']
          accommodation_data = JSON.parse(File.read(accommodations_file))

          accommodation = accommodation_data.detect {|data| data['id'] == traveller['booking']}

          if accommodation
            result[:booking] = "Booked at: #{accommodation['name']}"
          else
            result[:booking] = 'Unknown accommodation'
          end
        else
          result[:booking] = 'Not currently booked'
        end

        result
      end

      def find_accommodation(travellers_file, accommodations_file, id)
        accommodation_data = JSON.parse(File.read(accommodations_file))

        accommodation = accommodation_data.detect {|data| data['id'] == id}

        return {:accommodation => 'Accommodation not found'} unless accommodation

        result = {:accommodation => "Accommodation: #{accommodation['name']}"}

        if accommodation['guests']
          traveller_data = JSON.parse(File.read(travellers_file))

          travellers = traveller_data.select do |data|
            accommodation['guests'].include? data['id']
          end

          result[:guests] = travellers.collect {|data| data['name']}
        else
          result[:guests] = 'Currently no bookings'
        end

        result
      end
    end
  end
end