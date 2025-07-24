require 'csv'
require 'caxlsx'
# require 'axlsx'

class Form < ApplicationRecord
  belongs_to :website, optional: true
  has_many :data_entries, dependent: :destroy

  def all_payloads
    data_entries.pluck(:payload).map { |p| JSON.parse(p) }
  end

  def attributes
    all_payloads.first&.keys || []
  end

  def data_entries_to_csv
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all_payloads.each do |entry|
        csv << attributes.map { |attr| entry[attr] }
      end
    end
  end

  def data_entries_to_json
    all_payloads().as_json
  end

  def data_entries_to_excel
    package = Axlsx::Package.new
    workbook = package.workbook
    workbook.add_worksheet(name: "Data Entries") do |sheet|
      sheet.add_row attributes
      all_payloads.each do |entry|
        sheet.add_row attributes.map { |attr| entry[attr] }
      end
    end
    package.to_stream.read
  end
end
