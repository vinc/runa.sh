class RunJob < ApplicationJob
  queue_as :default

  def perform(run)
    run.start!

    cmd = run.task.input
    out = []
    IO.popen(cmd) do |io|
      until io.eof?
        return if run.reload.canceled?
        out << io.gets
        run.update(output: out.join)
      end
    end

    run.finish!
  end
end
