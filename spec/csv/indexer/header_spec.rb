# frozen_string_literal: true

RSpec.describe Csv::Indexer::Header do
  subject(:header) { described_class.new }

  let(:input_file) { File.join(__dir__, "..", "..", "fixtures", "input2.csv") }
  let(:csv) { CSV.parse(File.read(input_file), headers: true) }
  let(:headers) { csv.headers }

  describe "#build" do
    it "adds an id header to the first spot on the headers" do
      expect { header.build(headers) }.to change { headers[0] }.from("FirstName").to("id")
    end
  end

  describe "matching_headers" do
    context "when matching on phone" do
      it "matches the headers with the string phone in them" do
        expect(header.matching_headers(headers, ["phone"])).to match_array(["Phone1", "Phone2"])
      end
    end

    context "when matching on email" do
      it "matches the headers with the string email in them" do
        expect(header.matching_headers(headers, ["email"])).to match_array(["Email1", "Email2"])
      end
    end
  end
end
