module RunHelper
  def run_state(run)
    case run.state
    when "created" then "Queued"
    when "started" then "Running"
    else run.state.capitalize
    end
  end

  def run_color(run)
    case run.state
    when "started" then "warning"
    end
  end
end
