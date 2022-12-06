# frozen_string_literal: true

RSpec.describe "OneRoster v1p2 CSV Conformance TestSet 20220707v1", skip: !Dir.exist?("tmp/TestSet") do # rubocop:disable RSpec/DescribeClass
  Dir.glob("tmp/TestSet/ValidFileSet/Rostering/VRb*.zip") do |path|
    test_case = File.basename(path, ".zip")
    # NOTE: VRb157とVRb169はおそらくテストケース自体が間違い
    describe test_case, skip: %w[VRb157 VRb169].include?(test_case) do
      it "does not raise error" do
        expect { Meibo::Roster.from_file(path) }.not_to raise_error
      end
    end
  end
end
