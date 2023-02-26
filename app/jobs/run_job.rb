class RunJob < ApplicationJob
  queue_as :default

  def perform(run)
    run.start!
    Dir.mktmpdir do |dir|
      cmd = run.task.input
      out = []
      IO.popen(cmd, chdir: dir) do |io|
        until io.eof?
          return if run.reload.canceled?
          out << io.gets
          run.update(output: out.join)
        end
      end
    end
    run.finish!
  end
end
