require 'spec_helper'

describe 'ombi' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge!(concat_basedir: '/dne')
        end

        context 'ombi class without any parameters' do
          let(:params) do
          end
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_user('ombi') }
          it { is_expected.to contain_service('ombi') }
        end
      end
    end
  end
end
