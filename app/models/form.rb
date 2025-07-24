require 'csv'
# require 'axlsx'

class Form < ApplicationRecord
  belongs_to :website, optional: true
  has_many :data_entries, dependent: :destroy

  def data_entries_to_csv
    attributes = data_entries.first&.attributes&.keys || []
    CSV.generate(headers: true) do |csv|
      csv << attributes
      data_entries.find_each do |entry|
        csv << attributes.map { |attr| entry.send(attr) }
      end
    end
  end

  def data_entries_to_json
    data_entries.as_json
  end

  # def data_entries_to_excel
  #   attributes = data_entries.first&.attributes&.keys || []
  #   package = Axlsx::Package.new
  #   workbook = package.workbook
  #   workbook.add_worksheet(name: "Data Entries") do |sheet|
  #     sheet.add_row attributes
  #     data_entries.find_each do |entry|
  #       sheet.add_row attributes.map { |attr| entry.send(attr) }
  #     end
  #   end
  #   package.to_stream.read
  # end

  def add_data_entry(data_entry)
    data_entries << data_entry
  end

  def remove_data_entry(data_entry)
    data_entries.destroy(data_entry)
  end

  def all_data_entries
    data_entries
  end
end
