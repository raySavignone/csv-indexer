# frozen_string_literal: true

RSpec.describe Csv::Indexer do
  it "has a version number" do
    expect(Csv::Indexer::VERSION).not_to be nil
  end

  describe ".process" do
    let(:input_file) { File.join(__dir__, "..", "fixtures", "input2.csv") }
    let(:output_file) { File.join(__dir__, "..", "fixtures", "input2_indexed.csv") }
    let(:csv) { CSV.parse(File.read(output_file), headers: true) }

    context "when matching by phone and email columns" do
      before(:all) do
        Csv::Indexer.process(
          {
            input_file: File.join(__dir__, "..", "fixtures", "input2.csv"),
            match_on: ["phone", "email"]
          }
        )
      end

      after(:all) { File.delete(File.join(__dir__, "..", "fixtures", "input2_indexed.csv")) }

      it "Adds an id column as the first header" do
        expect(csv.headers[0]).to eq("id")
      end

      it "correctly maps the the rows matching them by the mathers" do
        ids = csv.map { |row| row["id"] }
        expect(ids).to match_array(["1", "1", "1", "1", "1", "2"])
      end
    end

    context "when matching by phone column" do
      before(:all) do
        Csv::Indexer.process(
          {
            input_file: File.join(__dir__, "..", "fixtures", "input2.csv"),
            match_on: ["phone"]
          }
        )
      end

      after(:all) { File.delete(File.join(__dir__, "..", "fixtures", "input2_indexed.csv")) }

      it "Adds an id column as the first header" do
        expect(csv.headers[0]).to eq("id")
      end

      it "correctly maps the the rows matching them by the mathers" do
        ids = csv.map { |row| row["id"] }
        expect(ids).to match_array(["1", "1", "1", "1", "2", "3"])
      end
    end

    context "when matching by email column" do
      before(:all) do
        Csv::Indexer.process(
          {
            input_file: File.join(__dir__, "..", "fixtures", "input2.csv"),
            match_on: ["email"]
          }
        )
      end

      after(:all) { File.delete(File.join(__dir__, "..", "fixtures", "input2_indexed.csv")) }

      it "Adds an id column as the first header" do
        expect(csv.headers[0]).to eq("id")
      end

      it "correctly maps the the rows matching them by the mathers" do
        ids = csv.map { |row| row["id"] }
        expect(ids).to match_array(["1", "1", "2", "2", "2", "3"])
      end
    end
  end
end
