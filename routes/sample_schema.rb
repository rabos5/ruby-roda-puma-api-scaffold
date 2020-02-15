# frozen_string_literal: true

require 'dry-validation'
require_relative '../core/core'

SampleSchema = Dry::Validation.Schema do
end

class SampleSchemaError < Core::SchemaError
  def initialize(msg)
    super(msg)
  end
end
