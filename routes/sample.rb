# frozen_string_literal: true

require 'json'
require 'logger'
require 'roda'
require_relative 'sample_schema'
require_relative '../core/core'

module Routes
  class Sample < Roda
    plugin :common_logger, LOGGER
    plugin :json

    route do |r|
      # i.e. GET /api/sample/get
      r.get 'get' do
        response['Access-Control-Allow-Origin'] = '*'

        status = 'success'
        message = 'success'
        result = r.params.to_s

        NetHTTP::Core::Utilities.convert_hash_keys(
          object: {
            status: status,
            message: message,
            result: result
          },
          format: 'camel',
          type: 'string'
        )
      end

      r.options do
        response['Access-Control-Allow-Origin'] = '*'
        response['Access-Control-Allow-Methods'] = 'GET, OPTIONS, POST'
        response['Access-Control-Allow-Headers'] = 'Access-Control-Allow-Origin, Content-Type, Origin'
      end

      # i.e. POST /api/sample/post
      r.post 'post' do
        response['Access-Control-Allow-Origin'] = '*'
        status = 'success'
        message = 'success'
        request_body = r.body.read
        result = NetHTTP::Core::Utilities.json_2_hash(
          request_body,
          'symbol',
          LOGGER
        )

        NetHTTP::Core::Utilities.convert_hash_keys(
          object: {
            status: status,
            message: message,
            result: result
          },
          format: 'camel',
          type: 'string'
        )
      end
    end
  end
end
