# frozen_string_literal: true

require "set"

module Csv
  module Indexer
    # Class to deal with header related data and methods for the output file.
    class Header
      def build(headers)
        headers.unshift("id")
      end

      def matching_headers(headers, match_on)
        headers.select do |header|
          match_on.any? { |matcher| match?(header, matcher) }
        end
      end

      private

      def match?(header, matcher)
        header.downcase.include?(matcher.downcase)
      end
    end
  end
end
