# frozen_string_literal: true

RSpec.describe "OneRoster v1p2 CSV Conformance TestSet 20220707v1", skip: !Dir.exist?("tmp/TestSet") do # rubocop:disable RSpec/DescribeClass
  Dir.glob("tmp/TestSet/InvalidFileSet/Rostering/IRb0*.zip") do |path|
    test_case = File.basename(path, ".zip")
    describe test_case do
      it "raise error" do
        expect { Meibo::Roster.from_file(path) }.to raise_error(Meibo::NotSupportedError)
      end
    end
  end

  Dir.glob("tmp/TestSet/InvalidFileSet/Rostering/IRb1*.zip") do |path|
    test_case = File.basename(path, ".zip")
    describe test_case do
      it "raise error (Missing Data)" do
        expect { Meibo::Roster.from_file(path) }.to raise_error(Meibo::MissingDataError)
      end
    end
  end

  sourced_id_cases = %w[
    IRb206
    IRb211
    IRb212
    IRb213
    IRb218
    IRb219
    IRb235
    IRb236
    IRb237
    IRb246
    IRb247
    IRb248
    IRb252
    IRb255
    IRb256
    IRb261
    IRb264
  ]

  Dir.glob("tmp/TestSet/InvalidFileSet/Rostering/IRb2*.zip") do |path|
    test_case = File.basename(path, ".zip")
    if sourced_id_cases.include?(test_case)
      # NOTE: IRb247はリソースとの関連の検査
      describe test_case, skip: test_case == "IRb247" do
        it "raise error (Data Rules)" do
          expect { Meibo::Roster.from_file(path) }.to raise_error(Meibo::DataNotFoundError)
        end
      end
    else
      describe test_case do
        it "raise error (Data Rules)" do
          expect { Meibo::Roster.from_file(path) }.to raise_error(Meibo::InvalidDataTypeError)
        end
      end
    end
  end

  Dir.glob("tmp/TestSet/InvalidFileSet/Rostering/IRb{3*,4[0-4]*}.zip") do |path|
    test_case = File.basename(path, ".zip")
    describe test_case do
      it "raise error" do
        expect { Meibo::Roster.from_file(path) }.to raise_error(Meibo::MissingHeadersError)
      end
    end
  end

  Dir.glob("tmp/TestSet/InvalidFileSet/Rostering/IRb4[5-9]*.zip") do |path|
    test_case = File.basename(path, ".zip")
    describe test_case do
      it "raise error" do
        expect { Meibo::Roster.from_file(path) }.to raise_error(Meibo::ScrambledHeadersError)
      end
    end
  end

  Dir.glob("tmp/TestSet/InvalidFileSet/Rostering/IRb5*.zip") do |path|
    test_case = File.basename(path, ".zip")
    describe test_case do
      it "raise error" do
        expect { Meibo::Roster.from_file(path) }.to raise_error(Meibo::InvalidDataTypeError)
      end
    end
  end
end
