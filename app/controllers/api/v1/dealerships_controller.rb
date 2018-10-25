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

      def export
        dealership_ids = params[:dealership_ids].split(',')
        dealerships = Dealership.where(id: dealership_ids).limit(500)
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
