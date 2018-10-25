module Api
  module V1
    class DealershipsController < ApplicationController
      def index
        @dealerships = Dealership.all.limit(500)
      end

      def find
        latitude = params[:latitude].to_f
        longitude = params[:longitude].to_f
        radius = params[:radius].to_f

        @dealerships, @circles = DealershipsFinderServices.new().find(latitude, longitude, radius)
      end
    end
  end
end
