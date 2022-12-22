# frozen_string_literal: true

D = Steep::Diagnostic

target :lib do
  signature "sig"

  # check "lib"
  check "lib/meibo.rb"
  check "lib/meibo/*.rb"
  check "Gemfile"
  library "csv", "date", "time"
  # configure_code_diagnostics(D::Ruby.lenient)
  configure_code_diagnostics(D::Ruby.strict)
end

# TODO: Write signatures for rspec
# target :spec do
#   signature "sig-private"
#   check "spec"
#   library "meibo"
# end
