require 'rails_helper'

RSpec.describe 'Import tasks', type: :task do
  context 'import:ipaddrs' do
    it 'adds ip addresses to Ipaddress models' do
      expect { invoke_task }.to change { Ipaddress.count }.from(0).to(3)
    end

    private

    def invoke_task
      task = Rake::Task['import:ipaddrs']
      task.reenable
      task.invoke
    end
  end
end
