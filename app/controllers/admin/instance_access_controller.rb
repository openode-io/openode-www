class Admin::InstanceAccessController < Admin::InstancesController
  skip_forgery_protection only: [:cmd]

  before_action do
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
  end

  def index
    redirect_to({ action: :deployments })
  end

  def deployments
    add_breadcrumb "Deployments",
                   admin_instance_access_deployments_path,
                   title: "Deployments"

    @deployments = api(:get, "/instances/#{@instance_id}/executions/list/Deployment")
  end

  def deployment
    add_breadcrumb "Deployments",
                   admin_instance_access_deployments_path,
                   title: "Deployments"

    @deployment_id = params[:deployment_id]

    @deployment = api(:get, "/instances/#{@instance_id}/executions/#{@deployment_id}")
  end

  def rollback
    @deployment_id = params[:deployment_id]

    api(:post, "/instances/#{@instance_id}/restart?parent_execution_id=#{@deployment_id}")

    redirect_to({
                  action: :deployments
                },
                notice: "The instance will be rollbacked shortly.")
  end

  def logs
    add_breadcrumb "Logs",
                   admin_instance_access_logs_path,
                   title: "Logs"

    @nb_lines = params&.dig('logs', 'nb_lines')&.to_i || 100

    retrieved_logs = api(:get, "/instances/#{@instance_id}/logs?nbLines=#{@nb_lines}")

    @logs = retrieved_logs&.dig('logs')
  end

  def activity_stream
    add_breadcrumb "Activity Stream",
                   admin_instance_access_activity_stream_path,
                   title: "Activity Stream"

    @events = api(:get, "/instances/#{@instance_id}/events")
  end

  def status
    add_breadcrumb "Status",
                   admin_instance_access_status_path,
                   title: "Status and Network"

    @status = api(:get, "/instances/#{@instance_id}/status")
    raw_network_stats = api(:get, "/instances/#{@instance_id}/stats/network")

    @network_stats = raw_network_stats.map do |s|
      {
        'date' => s['updated_at'],
        'value' =>
          ((s.dig('obj', 'rcv_bytes') || 0) + (s.dig('obj', 'tx_bytes') || 0)) /
            (1000 * 1000) # Mb
      }
    end
  end

  def event
    add_breadcrumb "Activity Stream",
                   admin_instance_access_activity_stream_path,
                   title: "Activity Stream"

    @event = api(:get, "/instances/#{@instance_id}/events/#{params[:event_id]}")
  end

  def console
    add_breadcrumb "Console",
                   admin_instance_access_console_path,
                   title: "Console"

    @doc_link = "/docs/platform/exec.md"
  end

  def cmd
    cmd = params[:cmd]

    result = begin
      api(:post, "/instances/#{@instance_id}/cmd", payload: { cmd: cmd })
             rescue StandardError => e
               {
                 'result' => {
                   'stdout' => "There was an issue processing the command. #{e}"
                 }
               }
    end

    render json: { msg: result&.dig('result') }
  end
end
