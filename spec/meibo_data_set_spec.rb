# frozen_string_literal: true

RSpec.describe Meibo::DataSet do
  describe "#check_semantically_consistent" do
    let(:data) { build(:meibo_academic_session) }
    let(:roster) { build(:meibo_roster) }

    it "raise error if sourcedId is blank" do
      data_set = described_class.new([build(:meibo_academic_session, sourced_id: nil)], roster:)
      expect do
        data_set.check_semantically_consistent
      end.to raise_error(Meibo::DataNotFoundError, "sourcedId\u304C\u3042\u308A\u307E\u305B\u3093")
    end

    it "does not raise error if sourcedId is unique" do
      data_set = described_class.new([data], roster:)
      expect { data_set.check_semantically_consistent }.not_to raise_error
    end

    it "raise error if sourcedId is not unique" do
      data_set = described_class.new([data, data], roster:)
      expect { data_set.check_semantically_consistent }.to raise_error(Meibo::SourcedIdDuplicatedError)
    end
  end
end
