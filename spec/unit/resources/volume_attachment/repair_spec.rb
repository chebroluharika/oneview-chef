require_relative './../../../spec_helper'

describe 'oneview_test::volume_attachment_repair' do
  let(:resource_name) { 'volume_attachment' }
  include_context 'chef context'

  let(:target_class) { OneviewSDK::API200::VolumeAttachment }

  it 'removes it if it does exist' do
    expect_any_instance_of(target_class).to receive(:retrieve!).and_return(true)
    expect_any_instance_of(target_class).to receive(:repair).and_return(true)
    expect(real_chef_run).to repair_oneview_volume_attachment('VolumeAttachment1')
  end

  it 'does nothing if it does not exist' do
    expect_any_instance_of(target_class).to receive(:retrieve!).and_return(false)
    expect_any_instance_of(target_class).to_not receive(:repair)
    expect(real_chef_run).to repair_oneview_volume_attachment('VolumeAttachment1')
  end
end
