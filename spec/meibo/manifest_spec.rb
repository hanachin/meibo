# frozen_string_literal: true

RSpec.describe Meibo::Manifest do
  describe "#file_attributes" do
    it "returns files filtered by file type" do
      manifest = described_class.new(
        file_academic_sessions: Meibo::ProcessingMode.bulk,
        file_categories: Meibo::ProcessingMode.absent,
        file_classes: Meibo::ProcessingMode.bulk,
        file_class_resources: Meibo::ProcessingMode.absent,
        file_courses: Meibo::ProcessingMode.bulk,
        file_course_resources: Meibo::ProcessingMode.absent,
        file_demographics: Meibo::ProcessingMode.delta,
        file_enrollments: Meibo::ProcessingMode.bulk,
        file_line_item_learning_objective_ids: Meibo::ProcessingMode.absent,
        file_line_items: Meibo::ProcessingMode.absent,
        file_line_item_score_scales: Meibo::ProcessingMode.absent,
        file_orgs: Meibo::ProcessingMode.bulk,
        file_resources: Meibo::ProcessingMode.absent,
        file_result_learning_objective_ids: Meibo::ProcessingMode.absent,
        file_results: Meibo::ProcessingMode.absent,
        file_result_score_scales: Meibo::ProcessingMode.absent,
        file_roles: Meibo::ProcessingMode.bulk,
        file_score_scales: Meibo::ProcessingMode.absent,
        file_user_profiles: Meibo::ProcessingMode.delta,
        file_user_resources: Meibo::ProcessingMode.absent,
        file_users: Meibo::ProcessingMode.bulk
      )
      expect(manifest.file_attributes(processing_mode: Meibo::ProcessingMode.bulk)).to contain_exactly(
        :file_academic_sessions,
        :file_classes,
        :file_courses,
        :file_enrollments,
        :file_orgs,
        :file_roles,
        :file_users
      )
      expect(manifest.file_attributes(processing_mode: Meibo::ProcessingMode.delta)).to contain_exactly(
        :file_demographics,
        :file_user_profiles
      )
      expect(manifest.file_attributes(processing_mode: Meibo::ProcessingMode.absent)).to contain_exactly(
        :file_categories,
        :file_class_resources,
        :file_course_resources,
        :file_line_item_learning_objective_ids,
        :file_line_items,
        :file_line_item_score_scales,
        :file_resources,
        :file_result_learning_objective_ids,
        :file_results,
        :file_result_score_scales,
        :file_score_scales,
        :file_user_resources
      )
    end
  end
end
