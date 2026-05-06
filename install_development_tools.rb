# frozen_string_literal: true

gem_group :development, :test do
  # Improve code debugging.
  gem "awesome_print"

  # Minimize database issues.
  gem "bullet"
end

gem_group :development do
  # Improve code debugging.
  gem "better_errors"
  gem "binding_of_caller"

  # Minimize database issues.
  gem "database_consistency", require: false

  # Minimize performance issues.
  gem "rubocop-performance", require: false
end

after_bundle do
  run "yes y | bundle exec rails g bullet:install"

  run "bundle exec database_consistency install"
end

inject_into_file ".rubocop.yml" do
  "\n# Minimize performance issues.\nplugins: rubocop-performance\n"
end

inject_into_file "config/ci.rb", after: "  step \"Security: Brakeman code analysis\", \"bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error\"" do
  "\n\n  # Run a database consistency check.\n  step \"Database: Database consistency check\", \"bundle exec database_consistency -f\"\n"
end
