json.id run.sequential_id
json.task do
  json.id run.task.uuid
end
json.extract! run, :host, :created_at, :started_at, :finished_at, :canceled_at, :output
