# frozen_string_literal: true

require 'json'
require 'logger'
require 'roda'
require_relative 'app_setup'
require_relative 'routes/sample'

class App < Roda
  plugin :common_logger, LOGGER
  plugin :json

  route do |r|
    r.on 'api' do
      r.on 'sample' do
        r.run Routes::Sample
      end

      r.get 'status' do
        "I have contained my rage for as long as possible, but I shall unleash my fury upon you like the crashing of a thousand waves!!  Begone, vile man!  Begone from me!  A starter car?!  This car is a finisher car!  A transporter of gods!  The golden god!  I am untethered, and my rage knows no bounds!!!"
      end

      r.get 'version' do
        version = '0.0.1'
        result = {
          version: version,
          docker: 'sample_docker_name' + ':' + version
        }

        NetHTTP::Core::Utilities.convert_hash_keys(
          object: {
            status: 'success',
            message: 'success',
            result: result
          },
          format: 'camel',
          type: 'string'
        )
      end
    end
  end
end
