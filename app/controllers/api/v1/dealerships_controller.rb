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

      def export
        dealerships = Dealership.all.limit(500)
        filename = "#{Date.today}.csv"

        response.headers['Exported-Filename'] = filename
        respond_to do |format|
          format.csv {
            send_data(dealerships.to_csv,
              type: 'text/csv; charset=utf-8; header=present',
              filename: filename
            )
          }
        end
      end
    end
  end
end
