class Dealership < ApplicationRecord
  require 'csv'

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.limit(500).each do |datum|
        csv << datum.attributes.values_at(*column_names)
      end
    end
  end
end
