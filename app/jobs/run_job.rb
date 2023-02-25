class RunJob < ApplicationJob
  queue_as :default

  def perform(run)
    run.start!

    cmd = run.task.input
    out = []
    IO.popen(cmd) do |io|
      until io.eof?
        out << io.gets
        run.update(output: out.join)
        return if run.reload.canceled?
      end
    end

    run.finish!
  end
end
