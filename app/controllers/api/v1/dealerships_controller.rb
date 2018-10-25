module Api
  module V1
    class DealershipsController < ApplicationController
      def index
        @dealerships = Dealership.all.limit(500)
      end

      def find
        latitude = 30.2047181
        longitude = -97.7835517
        radius = 5000.0.to_f

        @dealerships, @circles = DealershipsFinderServices.new().find(latitude, longitude, radius)
      end
    end
  end
end
