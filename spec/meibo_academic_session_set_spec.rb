# frozen_string_literal: true

RSpec.describe Meibo::AcademicSessionSet do
  describe '#check_semantically_consistent' do
    let(:parent_academic_session) { build(:meibo_academic_session) }
    let(:academic_session) { build(:meibo_academic_session, parent: parent_academic_session) }
    let(:roster) { build(:meibo_roster) }

    it "does not raise error if parent not found" do
      academic_session_set = Meibo::AcademicSessionSet.new([academic_session, parent_academic_session], roster: roster)
      expect { academic_session_set.check_semantically_consistent }.not_to raise_error
    end

    it "raise error if parent found" do
      academic_session_set = Meibo::AcademicSessionSet.new([academic_session], roster: roster)
      expect { academic_session_set.check_semantically_consistent }.to raise_error(Meibo::DataNotFoundError, /sourcedId: #{parent_academic_session.sourced_id} /)
    end
  end
end
