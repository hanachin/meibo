# frozen_string_literal: true

RSpec.describe Meibo::Manifest do
  describe '#file_attributes' do
    it "returns files filtered by file type" do
      manifest = Meibo::Manifest.build_from_default(
        file_academic_sessions: Meibo::Manifest::PROCESSING_MODES[:bulk],
        file_categories: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_classes: Meibo::Manifest::PROCESSING_MODES[:bulk],
        file_class_resources: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_courses: Meibo::Manifest::PROCESSING_MODES[:bulk],
        file_course_resources: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_demographics: Meibo::Manifest::PROCESSING_MODES[:delta],
        file_enrollments: Meibo::Manifest::PROCESSING_MODES[:bulk],
        file_line_item_learning_objective_ids: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_line_items: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_line_item_score_scales: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_orgs: Meibo::Manifest::PROCESSING_MODES[:bulk],
        file_resources: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_result_learning_objective_ids: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_results: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_result_score_scales: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_roles: Meibo::Manifest::PROCESSING_MODES[:bulk],
        file_score_scales: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_user_profiles: Meibo::Manifest::PROCESSING_MODES[:delta],
        file_user_resources: Meibo::Manifest::PROCESSING_MODES[:absent],
        file_users: Meibo::Manifest::PROCESSING_MODES[:bulk]
      )
      expect(manifest.file_attributes(processing_mode: Meibo::Manifest::PROCESSING_MODES[:bulk])).to contain_exactly(
        :file_academic_sessions,
        :file_classes,
        :file_courses,
        :file_enrollments,
        :file_orgs,
        :file_roles,
        :file_users
      )
      expect(manifest.file_attributes(processing_mode: Meibo::Manifest::PROCESSING_MODES[:delta])).to contain_exactly(
        :file_demographics,
        :file_user_profiles
      )
      expect(manifest.file_attributes(processing_mode: Meibo::Manifest::PROCESSING_MODES[:absent])).to contain_exactly(
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
