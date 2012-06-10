module LonelyPlanet
  class CliManager
    class << self
      def find_traveller(travellers_file, accommodations_file, id)
        traveller_data =  LonelyPlanet.read_json(travellers_file)

        traveller = LonelyPlanet::Search.search(traveller_data, id)

        return {:traveller => 'Traveller not found'} unless traveller

        result = {:traveller => "Traveller: #{traveller['name']}"}

        if traveller['booking']
          accommodation_data = LonelyPlanet.read_json(accommodations_file)

          accommodation = LonelyPlanet::Search.search(accommodation_data, traveller['booking'])

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
        accommodation_data = LonelyPlanet.read_json(accommodations_file)

        accommodation = LonelyPlanet::Search.search(accommodation_data, id)

        return {:accommodation => 'Accommodation not found'} unless accommodation

        result = {:accommodation => "Accommodation: #{accommodation['name']}"}

        if accommodation['guests']
          traveller_data = LonelyPlanet.read_json(travellers_file)

          travellers = traveller_data.select do |data|
            accommodation['guests'].include? data['id']
          end

          result[:guests] = travellers.collect {|data| data['name']}
        else
          result[:guests] = 'Currently no bookings'
        end

        result
      end

      def find_availability(travellers_file, accommodations_file, min_price, max_price, requirements)
        accommodation_data = LonelyPlanet.read_json(accommodations_file)

        search_params = {
            :requirements => requirements,
            :price_min => min_price,
            :price_max => max_price
        }

        accommodation = LonelyPlanet::Search.availability(accommodation_data, search_params)

        result = {}
        if accommodation
          result[:accommodation] = "#{accommodation['name']}, #{accommodation['price']}"
        else
          result[:accommodation] = 'No available accommodation matches the criteria'
        end

        result
      end

      def load_data(travellers_file, accommodations_file)
        File.delete(DATA_DIR + '/' + travellers_file) if File.exists?(DATA_DIR + '/' + travellers_file)
        File.delete(DATA_DIR + '/' + accommodations_file) if File.exists?(DATA_DIR + '/' + accommodations_file)

        travellers_seed_data = LonelyPlanet.read_json('/travellers_seed.json')
        accommodation_seed_data = LonelyPlanet.read_json('/accommodation_seed.json')

        result = LonelyPlanet::BookingMatcher.match(travellers_seed_data, accommodation_seed_data)

        File.open(DATA_DIR + '/' + travellers_file, 'w') do |f|
          f.write(result[:travellers].to_json)
        end

        File.open(DATA_DIR + '/' + accommodations_file, 'w') do |f|
          f.write(result[:accommodations].to_json)
        end
      end
    end
  end
end