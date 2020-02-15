# SimpleCov for test / coverage analysis:
require 'simplecov-json'
require 'simplecov-rcov'

# Coverage report formatters:
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::JSONFormatter,
  SimpleCov::Formatter::RcovFormatter
]

# Set coverage report directory:
SimpleCov.coverage_dir "reports/#{ENV['SIMPLECOV_TEST_SUITE']}/coverage/"

# Coverage Metrics / Guards:
SimpleCov.minimum_coverage 90
SimpleCov.minimum_coverage_by_file 90
SimpleCov.maximum_coverage_drop 0
SimpleCov.refuse_coverage_drop

SimpleCov.start 'test_frameworks'
