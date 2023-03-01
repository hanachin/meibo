# frozen_string_literal: true

RSpec.describe Meibo::JapanProfile::Classroom do
  describe ".parse" do
    context "when grades is empty" do
      let(:csv) { <<~CSV }
        sourcedId,status,dateLastModified,title,grades,courseSourcedId,classCode,classType,location,schoolSourcedId,termSourcedIds,subjects,subjectCodes,periods,metadata.jp.specialNeeds
        testClass,,,テスト組,,testCourse,,homeroom,,testOrg,testAcademicSession,,,,
      CSV

      it "success" do
        expect { described_class.parse(csv).to_a }.not_to raise_error
      end
    end

    context "when all grades are mext grade code" do
      let(:csv) { <<~CSV }
        sourcedId,status,dateLastModified,title,grades,courseSourcedId,classCode,classType,location,schoolSourcedId,termSourcedIds,subjects,subjectCodes,periods,metadata.jp.specialNeeds
        testClass,,,テスト組,"P1,P2,P3,P4,P5,P6,J1,J2,J3,H1,H2,H3,E1,E2,E3",testCourse,,homeroom,,testOrg,testAcademicSession,,,,
      CSV

      it "success" do
        expect { described_class.parse(csv).to_a }.not_to raise_error
      end
    end

    context "when some grades are not mext grade code" do
      let(:csv) { <<~CSV }
        sourcedId,status,dateLastModified,title,grades,courseSourcedId,classCode,classType,location,schoolSourcedId,termSourcedIds,subjects,subjectCodes,periods,metadata.jp.specialNeeds
        testClass,,,テスト組,"P0,P1,P2,P3,P4,P5,P6,P7,J0,J1,J2,J3,J4,H0,H1,H2,H3,H4,E0,E1,E2,E3,E4",testCourse,,homeroom,,testOrg,testAcademicSession,,,,
      CSV

      it "failed" do
        expect { described_class.parse(csv).to_a }.to raise_error(Meibo::InvalidDataTypeError)
      end
    end
  end
end
