class RunJob < ApplicationJob
  queue_as { self.arguments.first.task.runner }

  def perform(run)
    run.host = Socket.gethostname
    run.start!
    Dir.mktmpdir do |dir|
      out = []
      cmd = run.task.input
      IO.popen(cmd, chdir: dir) do |io|
        until io.eof?
          return if run.reload.canceled?
          out << io.gets
          run.update(output: out.join)
        end
      end

      break unless run.task.assets.present?

      run.task.assets.split(",").each do |filename|
        run.assets.attach(io: File.open(File.join(dir, filename)), filename: filename)
      end
    end
    run.finish!
  end
end
