# frozen_string_literal: true

module Meibo
  class AcademicSessionSet < DataSet
    def check_semantically_consistent
      super

      each do |academic_session|
        next unless academic_session.parent_sourced_id

        find(academic_session.parent_sourced_id)
      end
    end
  end
end
