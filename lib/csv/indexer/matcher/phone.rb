# frozen_string_literal: true

module Csv
  module Indexer
    module Matcher
      # Phone matcher applies transformations for phones so that they can be matched better. It also removes the 1 prefix.
      # This won't work as effeciently for numbers other than north america.
      class Phone
        def transform(value)
          new_value = value.tr("^0-9", "")

          new_value = new_value[1..-1] if new_value[0] == "1"
          new_value
        end
      end
    end
  end
end
