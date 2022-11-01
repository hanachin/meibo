# frozen_string_literal: true

RSpec.describe Meibo::DataSet do
  describe '#check_semantically_consistent' do
    let(:data) { build(:meibo_academic_session) }

    it "does not raise error if sourcedId is unique" do
      data_set = Meibo::DataSet.new([data])
      expect { data_set.check_semantically_consistent }.not_to raise_error
    end

    it "raise error if sourcedId is not unique" do
      data_set = Meibo::DataSet.new([data, data])
      expect { data_set.check_semantically_consistent }.to raise_error(Meibo::DataSet::SourcedIdDuplicatedError)
    end
  end
end
