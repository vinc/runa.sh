require 'rails_helper'

RSpec.describe RunJob, type: :job do
  it "runs a task" do
    run = Task.create(name: "test", command: "echo test").runs.create
    RunJob.perform_now(run)
    expect(run.output).to eq "test"
  end
end
