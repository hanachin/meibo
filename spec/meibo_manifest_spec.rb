# frozen_string_literal: true

RSpec.describe Meibo::Manifest do
  describe '#delta_file_attributes' do
    it "returns delta mode files" do
      manifest = Meibo::Manifest.build_from_default(
        file_academic_sessions: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_categories: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_classes: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_class_resources: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_courses: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_course_resources: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_demographics: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_enrollments: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_line_item_learning_objective_ids: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_line_items: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_line_item_score_scales: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_orgs: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_resources: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_result_learning_objective_ids: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_results: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_result_score_scales: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_roles: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_score_scales: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_user_profiles: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_user_resources: Meibo::Manifest::CSV_FILE_TYPE[:delta],
        file_users: Meibo::Manifest::CSV_FILE_TYPE[:delta]
      )
      expect(manifest.delta_file_attributes).to eq([
        :file_academic_sessions,
        :file_categories,
        :file_classes,
        :file_class_resources,
        :file_courses,
        :file_course_resources,
        :file_demographics,
        :file_enrollments,
        :file_line_item_learning_objective_ids,
        :file_line_items,
        :file_line_item_score_scales,
        :file_orgs,
        :file_resources,
        :file_result_learning_objective_ids,
        :file_results,
        :file_result_score_scales,
        :file_roles,
        :file_score_scales,
        :file_user_profiles,
        :file_user_resources,
        :file_users
      ])
    end

    it "does not returns bulk mode files" do
      manifest = Meibo::Manifest.build_from_default(
        file_academic_sessions: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_categories: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_classes: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_class_resources: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_courses: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_course_resources: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_demographics: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_enrollments: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_line_item_learning_objective_ids: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_line_items: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_line_item_score_scales: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_orgs: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_resources: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_result_learning_objective_ids: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_results: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_result_score_scales: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_roles: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_score_scales: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_user_profiles: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_user_resources: Meibo::Manifest::CSV_FILE_TYPE[:bulk],
        file_users: Meibo::Manifest::CSV_FILE_TYPE[:bulk]
      )
      expect(manifest.delta_file_attributes).to be_empty
    end
  end
end
