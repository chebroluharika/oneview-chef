# (C) Copyright 2020 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

require_relative './../../../spec_helper'

describe 'oneview_test_api1800_c7000::fc_network_delete_bulk' do
  let(:resource_name) { 'fc_network' }
  include_context 'chef context'

  it 'deletes it if it exist' do
    expect_any_instance_of(OneviewSDK::API1800::C7000::FCNetwork).to receive(:delete_bulk).and_return(true)
    expect(real_chef_run).to delete_bulk_oneview_fc_network('FC1')
  end
end
