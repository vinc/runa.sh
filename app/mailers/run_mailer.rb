class RunMailer < ApplicationMailer
  def finished_email
    @run = params[:run]
    @url = ENV["RUNA_API_URL"]
    mail(to: @run.task.user.email, subject: "[Runa] #{@run.task.name} ##{@run.sequential_id}")
  end
end
