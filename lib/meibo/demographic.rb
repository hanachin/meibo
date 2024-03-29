# frozen_string_literal: true

module Meibo
  class Demographic
    include DataModel

    SEX = {
      male: "male",
      female: "female",
      unspecified: "unspecified",
      other: "other"
    }.freeze

    define_attributes(
      sourced_id: "sourcedId",
      status: "status",
      date_last_modified: "dateLastModified",
      birth_date: "birthDate",
      sex: "sex",
      american_indian_or_alaska_native: "americanIndianOrAlaskaNative",
      asian: "asian",
      black_or_african_american: "blackOrAfricanAmerican",
      native_hawaiian_or_other_pacific_islander: "nativeHawaiianOrOtherPacificIslander",
      white: "white",
      demographic_race_two_or_more_races: "demographicRaceTwoOrMoreRaces",
      hispanic_or_latino_ethnicity: "hispanicOrLatinoEthnicity",
      country_of_birth_code: "countryOfBirthCode",
      state_of_birth_abbreviation: "stateOfBirthAbbreviation",
      city_of_birth: "cityOfBirth",
      public_school_residence_status: "publicSchoolResidenceStatus"
    )

    define_converters(
      boolean: %i[
        american_indian_or_alaska_native
        asian
        black_or_african_american
        native_hawaiian_or_other_pacific_islander
        white
        demographic_race_two_or_more_races
        hispanic_or_latino_ethnicity
      ],
      date: [:birth_date],
      datetime: [:date_last_modified],
      enum: { sex: [*SEX.values, ENUM_EXT_PATTERN] },
      required: [:sourced_id],
      status: [:status]
    )

    def initialize(sourced_id:, status: nil, date_last_modified: nil, birth_date: nil, sex: nil,
                   american_indian_or_alaska_native: nil, asian: nil, black_or_african_american: nil, native_hawaiian_or_other_pacific_islander: nil, white: nil, demographic_race_two_or_more_races: nil, hispanic_or_latino_ethnicity: nil, country_of_birth_code: nil, state_of_birth_abbreviation: nil, city_of_birth: nil, public_school_residence_status: nil, **extension_fields)
      @sourced_id = sourced_id
      @status = status
      @date_last_modified = date_last_modified
      @birth_date = birth_date
      @sex = sex
      @american_indian_or_alaska_native = american_indian_or_alaska_native
      @asian = asian
      @black_or_african_american = black_or_african_american
      @native_hawaiian_or_other_pacific_islander = native_hawaiian_or_other_pacific_islander
      @white = white
      @demographic_race_two_or_more_races = demographic_race_two_or_more_races
      @hispanic_or_latino_ethnicity = hispanic_or_latino_ethnicity
      @country_of_birth_code = country_of_birth_code
      @state_of_birth_abbreviation = state_of_birth_abbreviation
      @city_of_birth = city_of_birth
      @public_school_residence_status = public_school_residence_status
      @extension_fields = extension_fields
    end

    def collection
      Meibo.current_roster.demographics
    end

    def male?
      sex == SEX[:male]
    end

    def female?
      sex == SEX[:female]
    end

    def unspecified?
      sex == SEX[:unspecified]
    end

    def other?
      sex == SEX[:other]
    end

    def user
      Meibo.current_roster.users.find(sourced_id)
    end
  end
end
