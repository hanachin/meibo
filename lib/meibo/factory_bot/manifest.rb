# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :meibo_manifest, class: 'Meibo::Manifest' do
    initialize_with { new(**attributes) }

    manifest_version { Meibo::Manifest::EXPECTED_VALUES[:manifest_version] }
    oneroster_version { Meibo::Manifest::EXPECTED_VALUES[:oneroster_version] }
    file_academic_sessions { Meibo::Manifest::EXPECTED_VALUES[:file_academic_sessions] }
    file_categories { Meibo::Manifest::EXPECTED_VALUES[:file_categories] }
    file_classes { Meibo::Manifest::EXPECTED_VALUES[:file_classes] }
    file_class_resources { Meibo::Manifest::EXPECTED_VALUES[:file_class_resources] }
    file_courses { Meibo::Manifest::EXPECTED_VALUES[:file_courses] }
    file_course_resources { Meibo::Manifest::EXPECTED_VALUES[:file_course_resources] }
    file_demographics { Meibo::Manifest::EXPECTED_VALUES[:file_demographics] }
    file_enrollments { Meibo::Manifest::EXPECTED_VALUES[:file_enrollments] }
    file_line_item_learning_objective_ids { Meibo::Manifest::EXPECTED_VALUES[:file_line_item_learning_objective_ids] }
    file_line_items { Meibo::Manifest::EXPECTED_VALUES[:file_line_items] }
    file_line_item_score_scales { Meibo::Manifest::EXPECTED_VALUES[:file_line_item_score_scales] }
    file_orgs { Meibo::Manifest::EXPECTED_VALUES[:file_orgs] }
    file_resources { Meibo::Manifest::EXPECTED_VALUES[:file_resources] }
    file_result_learning_objective_ids { Meibo::Manifest::EXPECTED_VALUES[:file_result_learning_objective_ids] }
    file_results { Meibo::Manifest::EXPECTED_VALUES[:file_results] }
    file_result_score_scales { Meibo::Manifest::EXPECTED_VALUES[:file_result_score_scales] }
    file_roles { Meibo::Manifest::EXPECTED_VALUES[:file_roles] }
    file_score_scales { Meibo::Manifest::EXPECTED_VALUES[:file_score_scales] }
    file_user_profiles { Meibo::Manifest::EXPECTED_VALUES[:file_user_profiles] }
    file_user_resources { Meibo::Manifest::EXPECTED_VALUES[:file_user_resources] }
    file_users { Meibo::Manifest::EXPECTED_VALUES[:file_users] }
  end
end
