# frozen_string_literal: true

require_relative "indexer/version"
require_relative "indexer/header"
require_relative "indexer/index"
require "csv"

module Csv
  # Main Module for interaction with the gem.
  module Indexer
    class Error < StandardError; end

    def self.process(options = {})
      input_file = options.fetch(:input_file)
      match_on = options.fetch(:match_on)
      output_file = input_file.gsub(".csv", "_indexed.csv")

      table = CSV.parse(File.read(input_file), headers: true)
      new_header = Csv::Indexer::Header.new
      matching_headers = new_header.matching_headers(table.headers, match_on)

      puts "Indexing #{input_file} by columns: #{matching_headers.join(", ")}."
      headers = new_header.build(table.headers)
      write_to_output(output_file, headers, table, matching_headers)

      output_file
    end

    def self.write_to_output(output_file, headers, table, matching_headers)
      index = Csv::Indexer::Index.new

      CSV.open(output_file, "w") do |csv|
        csv << headers

        table.each do |row|
          row = index.index_row(row, matching_headers)
          csv << headers.map { |header| row[header] }
        end
      end
    end
  end
end
