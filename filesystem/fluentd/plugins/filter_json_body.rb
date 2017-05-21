require 'fluent/filter'
require 'json'

module Fluent
	class JsonBodyFilter < Filter
		Fluent::Plugin.register_filter('json_body', self)

		# config_param works like other plugins

		def configure(conf)
			super
			# do the usual configuration here
		end

		def start
			super
			# This is the first method to be called when it starts running
			# Use it to allocate resources, etc.
		end

		def shutdown
			super
			# This method is called when Fluentd is shutting down.
			# Use it to free up resources, etc.
		end

		def filter(tag, time, record)
			# This method implements the filtering logic for individual filters
			# It is internal to this class and called by filter_stream unless
			# the user overrides filter_stream.

			begin	
				if log = record['log']
					record['logData'] = JSON.parse(log)
				end
			rescue JSON::JSONError => e
				record['logData'] = {_json_parse_error: e.message}
			end

			record
		end
	end
end
