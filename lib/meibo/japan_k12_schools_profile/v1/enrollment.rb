# frozen_string_literal: true

module Meibo
  module JapanK12SchoolsProfile
    module V1
      class Enrollment < ::Meibo::JapanProfile::V1_2::Enrollment
        define_attributes(
          superclass.attribute_names_to_header_fields.merge(
            shusseki_no: "metadata.jp.shussekiNo",
            public_flg: "metadata.jp.publicFlg"
          )
        )
      end
    end
  end
end
