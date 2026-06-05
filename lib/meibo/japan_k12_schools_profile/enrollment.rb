# frozen_string_literal: true

module Meibo
  module JapanK12SchoolsProfile
    class Enrollment < ::Meibo::JapanProfile::Enrollment
      define_attributes(
        superclass.attribute_names_to_header_fields.merge(
          shusseki_no: "metadata.jp.shussekiNo",
          public_flg: "metadata.jp.publicFlg"
        )
      )
    end
  end
end
