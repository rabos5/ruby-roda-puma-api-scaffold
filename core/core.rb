# frozen_string_literal: true

class Core
  def self.schema_validation(opts, schema)
    results = schema.call(opts)
    if results.success?
      return nil
    else
      return results.messages
    end
  end

  class SchemaError < StandardError
    def initialize(msg)
      super(msg)
    end
  end

  class Utilities
    def self.true?(obj)
      obj.to_s.downcase == 'true'
    end

    def self.false?(obj)
      obj.to_s.downcase == 'false'
    end
  end
end
