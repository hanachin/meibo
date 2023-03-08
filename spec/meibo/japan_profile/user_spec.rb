# frozen_string_literal: true

RSpec.describe Meibo::JapanProfile::User do
  describe ".parse" do
    context "when grades is empty" do
      let(:csv) { <<~CSV }
        sourcedId,status,dateLastModified,enabledUser,username,userIds,givenName,familyName,middleName,identifier,email,sms,phone,agentSourcedIds,grades,password,userMasterIdentifier,preferredGivenName,preferredMiddleName,preferredFamilyName,primaryOrgSourcedId,pronouns,metadata.jp.kanaGivenName,metadata.jp.kanaFamilyName,metadata.jp.kanaMiddleName,metadata.jp.homeClass
        testUser,,,true,testUser,,太郎,山田,,,,,,,,,,,,,,testOrg,,,,,
      CSV

      it "success" do
        expect { described_class.parse(csv).to_a }.not_to raise_error
      end
    end

    context "when all grades are mext grade code" do
      let(:csv) { <<~CSV }
        sourcedId,status,dateLastModified,enabledUser,username,userIds,givenName,familyName,middleName,identifier,email,sms,phone,agentSourcedIds,grades,password,userMasterIdentifier,preferredGivenName,preferredMiddleName,preferredFamilyName,primaryOrgSourcedId,pronouns,metadata.jp.kanaGivenName,metadata.jp.kanaFamilyName,metadata.jp.kanaMiddleName,metadata.jp.homeClass
        testUser,,,true,testUser,,太郎,山田,,,,,,,"E1,E2",,,,,,,testOrg,,,,,
      CSV

      it "success" do
        expect { described_class.parse(csv).to_a }.not_to raise_error
      end
    end

    context "when some grades are not mext grade code" do
      let(:csv) { <<~CSV }
        sourcedId,status,dateLastModified,enabledUser,username,userIds,givenName,familyName,middleName,identifier,email,sms,phone,agentSourcedIds,grades,password,userMasterIdentifier,preferredGivenName,preferredMiddleName,preferredFamilyName,primaryOrgSourcedId,pronouns,metadata.jp.kanaGivenName,metadata.jp.kanaFamilyName,metadata.jp.kanaMiddleName,metadata.jp.homeClass
        testUser,,,true,testUser,,太郎,山田,,,,,,,"E1,FOO",,,,,,,testOrg,,,,,
      CSV

      it "failed" do
        expect { described_class.parse(csv).to_a }.to raise_error(Meibo::InvalidDataTypeError)
      end
    end
  end
end
