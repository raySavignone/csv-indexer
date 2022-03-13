# frozen_string_literal: true

module Csv
  module Indexer
    module Matcher
      # Base class for a generic matcher that does not apply transformations to the row values
      class Base
        def transform(value)
          value
        end
      end
    end
  end
end
