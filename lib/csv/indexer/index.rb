# frozen_string_literal: true

require_relative "matcher/base"
require_relative "matcher/phone"

module Csv
  module Indexer
    # Indexing a document's rows based on the matching columns.
    # the internal state of the object keeps track of the row values
    # that have been given an index.
    class Index
      def initialize
        @index = {}
        @uniqueness_count = 1
      end

      def index_row(row, match_on_headers)
        row_values = row_index_values(row, match_on_headers)
        index_value = matching_row_index(row_values)

        if row_values.empty? || index_value.nil?
          use_new_index(row, row_values)
        else
          use_old_index(row, row_values, index_value)
        end

        row
      end

      private

      def row_index_values(row, match_on_headers)
        match_on_headers.map do |header|
          value = row[header]
          value.nil? ? value : header_matcher(header).transform(value)
        end.compact
      end

      def header_matcher(header)
         # Only two matcher for now.
        header.downcase.to_sym == :phone ? Csv::Indexer::Matcher::Phone.new : Csv::Indexer::Matcher::Base.new
      end

      def matching_row_index(values)
        values.map { |value| @index[value] }.compact.first
      end

      def use_new_index(row, row_values)
        row_values.each { |value| @index[value] = @uniqueness_count }
        row["id"] = @uniqueness_count
        @uniqueness_count += 1
      end

      def use_old_index(row, row_values, index)
        row["id"] = index
        row_values.each { |value| @index[value] = index }
      end
    end
  end
end
