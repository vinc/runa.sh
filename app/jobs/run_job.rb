class RunJob < ApplicationJob
  queue_as :default

  def perform(run)
    run.start!

    cmd = run.task.command
    out = ""
    IO.popen(cmd) do |io|
      until io.eof?
        out += io.gets
        run.update(output: out)
      end
    end

    run.finish!
  end
end
