class RunJob < ApplicationJob
  queue_as { self.arguments.first.task.runner }

  def perform(run)
    run.host = Socket.gethostname
    run.start!
    Dir.mktmpdir do |dir|
      out = []
      cmd = run.task.input
      env = {
        "RUNA_API_KEY" => run.task.user.api_key,
        "RUNA_API_URL" => ENV["RUNA_API_URL"],
      }
      opt = {
        chdir: dir,
        err: [:child, :out],
        unsetenv_others: true,
      }
      IO.popen(env, cmd, opt) do |io|
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
