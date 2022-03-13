# frozen_string_literal: true

RSpec.describe Csv::Indexer::Index do
  subject(:index) { described_class.new }

  let(:input_file) { File.join(__dir__, "..", "..", "fixtures", "input2.csv") }
  let(:csv) { CSV.parse(File.read(input_file), headers: true) }
  let(:index_row) { csv.map { |row| row["id"] } }

  describe "#index_row" do
    context "when match_on email" do
      let(:match_on_headers) { ["Email1", "Email2"] }

      context "with a previous row index for match_on" do
        let(:previous_matching_row) { csv[0] }
        let(:row) { csv[1] }

        it "uses the same index on the second matching row" do
          index.index_row(previous_matching_row, match_on_headers)
          index.index_row(row, match_on_headers)
          expect(row["id"]).to eq(previous_matching_row["id"])
        end
      end

      context "with no previous row index for match" do
        let(:previous_matching_row) { csv[0] }
        let(:row) { csv[5] }

        it "uses a new index value for the row" do
          index.index_row(previous_matching_row, match_on_headers)
          index.index_row(row, match_on_headers)
          expect(row["id"]).not_to eq(previous_matching_row["id"])
        end
      end
    end

    context "when match_on phone" do
      let(:match_on_headers) { ["Phone1", "Phone2"] }

      context "with a previous row index for match_on" do
        let(:previous_matching_row) { csv[0] }
        let(:row) { csv[1] }

        it "uses the same index on the second matching row" do
          index.index_row(previous_matching_row, match_on_headers)
          index.index_row(row, match_on_headers)
          expect(row["id"]).to eq(previous_matching_row["id"])
        end
      end

      context "with no previous row index for match" do
        let(:previous_matching_row) { csv[0] }
        let(:row) { csv[4] }

        it "uses a new index value for the row" do
          index.index_row(previous_matching_row, match_on_headers)
          index.index_row(row, match_on_headers)
          expect(row["id"]).not_to eq(previous_matching_row["id"])
        end
      end
    end

    context "when match_on email & phone" do
      let(:match_on_headers) { ["Email1", "Email2", "Phone1", "Phone2"] }

      context "with a previous row index for match_on" do
        let(:previous_matching_row) { csv[0] }
        let(:row) { csv[1] }

        it "uses the same index on the second matching row" do
          index.index_row(previous_matching_row, match_on_headers)
          index.index_row(row, match_on_headers)
          expect(row["id"]).to eq(previous_matching_row["id"])
        end
      end

      context "with no previous row index for match" do
        let(:previous_matching_row) { csv[0] }
        let(:row) { csv[5] }

        it "uses a new index value for the row" do
          index.index_row(previous_matching_row, match_on_headers)
          index.index_row(row, match_on_headers)
          expect(row["id"]).not_to eq(previous_matching_row["id"])
        end
      end
    end
  end
end
