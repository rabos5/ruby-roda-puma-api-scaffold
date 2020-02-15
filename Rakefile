# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

# $ rake rubocop
desc 'Executes rubocop syntax check'
task :rubocop do |_task|
  sh 'bundle exec rubocop \
      --require rubocop/formatter/checkstyle_formatter \
      --format RuboCop::Formatter::CheckstyleFormatter -o reports/rubocop/syntax_results.xml \
      --format html -o reports/rubocop/index.html || true'
end

# $ rake unit_tests
# $ SIMPLECOV='true' rake unit_tests
Desc 'Executes unit tests'
task :unit_tests do |_task, args|
  rm_rf 'reports/unit/test_results.xml'
  ENV['SIMPLECOV_TEST_SUITE'] = 'unit'
  sh 'rspec spec/ --format RspecJunitFormatter --out reports/unit/test_results.xml'
end

# $ rake integration_tests
# $ SIMPLECOV='true' rake integration_tests
desc 'Executes integration tests'
task :integration_tests do |_task, args|
  rm 'reports/integration/test_results.xml'
  ENV['SIMPLECOV_TEST_SUITE'] = 'integration'
  sh 'rspec spec/ --format RspecJunitFormatter --out reports/integration/test_results.xml'
end
