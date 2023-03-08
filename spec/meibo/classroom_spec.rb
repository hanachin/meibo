# frozen_string_literal: true

RSpec.describe Meibo::Classroom do
  describe ".parse" do
    context "when classType is valid" do
      let(:csv) { <<~CSV }
        sourcedId,status,dateLastModified,title,grades,courseSourcedId,classCode,classType,location,schoolSourcedId,termSourcedIds,subjects,subjectCodes,periods,metadata.jp.specialNeeds
        testClass,,,テスト組,,testCourse,,homeroom,,testOrg,testAcademicSession,,,,
        testClass,,,テスト組,,testCourse,,scheduled,,testOrg,testAcademicSession,,,,
        testClass,,,テスト組,,testCourse,,ext:hoge,,testOrg,testAcademicSession,,,,
      CSV

      it "success" do
        expect { described_class.parse(csv).to_a }.not_to raise_error
      end
    end

    context "when classType is not valid" do
      let(:csv) { <<~CSV }
        sourcedId,status,dateLastModified,title,grades,courseSourcedId,classCode,classType,location,schoolSourcedId,termSourcedIds,subjects,subjectCodes,periods,metadata.jp.specialNeeds
        testClass,,,テスト組,,testCourse,,ext:,,testOrg,testAcademicSession,,,,
      CSV

      it "failed" do
        expect { described_class.parse(csv).to_a }.to raise_error(Meibo::InvalidDataTypeError)
      end
    end
  end
end
