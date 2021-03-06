# (c) Copyright 2020 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

require_relative 'api800'

module OneviewCookbook
  module ImageStreamer
    # Module for Image Streamer API 1000 Resources
    module API1000
      # Get resource class that matches the type given
      # @param [String] type Name of the desired class type
      # @param [String] variant Variant is ignored
      # @return [Class] Resource class or nil if not found
      def self.provider_named(type, _variant = nil)
        new_type = type.to_s.downcase.gsub(/[ -_]/, '') + 'provider'
        constants.each do |c|
          klass = OneviewCookbook::ImageStreamer::API1000.const_get(c)
          next unless klass.is_a?(Class) && klass < OneviewCookbook::ResourceProvider
          name = klass.name.split('::').last.downcase.delete('_').delete('-')
          return klass if new_type =~ /^#{name}$/
        end
        raise "The '#{type}' resource does not exist for Image Streamer API version 1000."
      end
    end
  end
end

# Load all API-specific resources:
Dir[File.dirname(__FILE__) + '/api1000/*.rb'].each { |file| require file }
