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

# NOTE 1: This example requires two Scopes named "Scope1" and "Scope2" to be present in the appliance.
# NOTE 2: The api_version client should be 300 or greater if you run the examples using Scopes
# NOTE 3: As a pre-requisite, create SAN1_0

my_client = {
  url: ENV['ONEVIEWSDK_URL'],
  user: ENV['ONEVIEWSDK_USER'],
  password: ENV['ONEVIEWSDK_PASSWORD'],
  api_version: 2000
}

# Example: Create and manage a new fc network
oneview_fc_network 'Fc1' do
  data(
    autoLoginRedistribution: true,
    fabricType: 'FabricAttach'
  )
  client my_client
  action :create
end

# Example: Create a new fc network only if it doesn't exist.
oneview_fc_network 'Fc1' do
  data(
    autoLoginRedistribution: true,
    fabricType: 'FabricAttach',
    bandwidth: {
      typicalBandwidth: 2000,
      maximumBandwidth: 9000
    }
  )
  associated_san 'SAN1_0'
  client my_client
  action :create_if_missing
end

# This examples works only from API1800
# Example: Bulk deletes fc networks.
oneview_fc_network 'None' do
  client my_client
  data(
    networkUris: [
      '/rest/fc-networks/af98dc4a-0982-4324-9700-5aed3245615b',
      '/rest/fc-networks/40e9e41d-31c2-40dc-878c-7a7f0720ea8a'
    ]
  )
  action :delete_bulk
  only_if { client[:api_version] >= 1800 }
end

# Example: Adds 'Fc1' to 'Scope1' and 'Scope2'
# Available only in Api300 and Api500
oneview_fc_network 'Fc1' do
  client my_client
  scopes ['Scope1', 'Scope2']
  action :add_to_scopes
  only_if { client[:api_version] == 300 || client[:api_version] == 500 }
end

# Example: Removes 'Fc1' from 'Scope1'
# Available only in Api300 and Api500
oneview_fc_network 'Fc1' do
  client my_client
  scopes ['Scope1']
  action :remove_from_scopes
  only_if { client[:api_version] == 300 || client[:api_version] == 500 }
end

# Example: Replaces 'Scope1' and 'Scope2' for 'Fc1'
# Available only in Api300 and Api500
oneview_fc_network 'Fc1' do
  client my_client
  scopes ['Scope1', 'Scope2']
  action :replace_scopes
  only_if { client[:api_version] == 300 || client[:api_version] == 500 }
end

# Example: Replaces all scopes to empty list of scopes
# Available only in Api300 and Api500
oneview_fc_network 'Fc1' do
  client my_client
  operation 'replace'
  path '/scopeUris'
  value []
  action :patch
  only_if { client[:api_version] == 300 || client[:api_version] == 500 }
end

# Example: Reset the connection template for a fc network
oneview_fc_network 'Fc1' do
  client my_client
  action :reset_connection_template
end

# Example: Delete an fc network
oneview_fc_network 'Fc1' do
  client my_client
  action :delete
end
