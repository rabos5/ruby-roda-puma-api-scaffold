# frozen_string_literal: true

require 'connection_pool'
require 'dotenv/load'
require 'logger'
require 'rb-net_http-client'

date_string = Time.now.strftime('%Y%m%d')
rack_env = ENV['RACK_ENV'].downcase
Dotenv.load(".env.#{rack_env}")

Logger.class_eval { alias :write :'<<' }
LOGGER = case ENV['LOG_TO'].to_s.downcase
         when 'file'
           Logger.new("logs/#{date_string}_#{rack_env}.log")
         else
           Logger.new(STDOUT)
         end

LOGGER.level = case ENV['LOG_LEVEL'].to_s.downcase
               when 'unknown'
                 Logger::UNKNOWN
               when 'fatal'
                 Logger::FATAL
               when 'error'
                 Logger::ERROR
               when 'warn'
                 Logger::WARN
               when 'info'
                 Logger::INFO
               when 'debug'
                 Logger::DEBUG
               else
                 Logger::INFO
               end

size = (ENV['NET_HTTP_CLIENT_POOL_SIZE'] ||= '15').to_i
timeout = (ENV['NET_HTTP_CLIENT_POOL_TIMEOUT'] ||= '30').to_i

NET_HTTP_CLIENT_POOL = ConnectionPool.new(size: size, timeout: timeout) do
  NetHTTP.client(
    logger: LOGGER,
    uri: 'http://localhost'
  )
end
