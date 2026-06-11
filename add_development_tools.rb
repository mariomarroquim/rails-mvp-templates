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

  # Minimize performance issues.
  gem "rubocop-performance", require: false
end

after_bundle do
  run "yes y | bundle exec rails g bullet:install"
end

inject_into_file ".rubocop.yml" do
  "\n# Minimize performance issues.\nplugins: rubocop-performance\n"
end
