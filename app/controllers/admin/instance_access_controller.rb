class Admin::InstanceAccessController < Admin::InstancesController
  skip_forgery_protection only: [:cmd]

  before_action do
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    @website_summary = api(:get, "/instances/#{@website.id}/summary")
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

  def prepare_snapshots_doc_link
    @doc_link = "/docs/platform/snapshots.md"
  end

  def snapshots
    add_breadcrumb "Snapshots",
                   admin_instance_access_snapshots_path,
                   title: "Snapshots"
    prepare_snapshots_doc_link

    workdir = if @website.status == 'online'
                result = api(:post, "/instances/#{@instance_id}/cmd",
                             payload: {
                               cmd: 'pwd'
                             })

                result.dig('result', 'stdout')&.strip
    end

    @paths = (workdir ? [{ path: "Workdir (#{workdir})", id: workdir }] : []) +
             (@website.storage_areas || []).map do |storage_area|
               {
                 path: "Storage area (#{storage_area})",
                 id: storage_area
               }
             end
  end

  def create_snapshot
    path = params.dig('website', 'path')

    api(:post, "/instances/#{@instance_id}/snapshots",
        payload: { path: path })

    redirect_to({
                  action: :list_snapshots
                },
                notice: "The snapshot will be prepared shortly.")
  end

  def list_snapshots
    add_breadcrumb "Snapshots",
                   admin_instance_access_snapshots_path,
                   title: "Snapshots"
    prepare_snapshots_doc_link

    @snapshots = api(:get, "/instances/#{@instance_id}/snapshots")
                 .map do |snapshot|
      snapshot['expired'] = DateTime.parse(snapshot['expire_at']) <= DateTime.now

      snapshot
    end
  end

  def get_snapshot
    add_breadcrumb "Snapshots",
                   admin_instance_access_snapshots_path,
                   title: "Snapshots"

    @snapshot = api(:get, "/instances/#{@instance_id}/snapshots/#{params['snapshot_id']}")
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

  def exec_top_processes
    cmd = 'top -b -n1'
    result = api(:post, "/instances/#{@instance_id}/cmd",
                 payload: {
                   cmd: cmd
                 })
    result.dig('result', 'stdout')
          .lines
          .reject { |line| line.include?(cmd) } [3..-1]
          .join
  end

  def exec_memory_usage_megabytes
    result = api(:post, "/instances/#{@instance_id}/cmd",
                 payload: {
                   cmd: 'cat /sys/fs/cgroup/memory/memory.usage_in_bytes'
                 })
    result_bytes = result.dig('result', 'stdout').to_i

    result_bytes / (1024.0 * 1024.0)
  end

  def status
    add_breadcrumb "Status",
                   admin_instance_access_status_path,
                   title: "Status and Network"

    @status = api(:get, "/instances/#{@instance_id}/status")
    raw_network_stats = api(:get, "/instances/#{@instance_id}/stats/network")

    @top_result = ""
    @mem_mb = nil

    if @website.status == 'online'
      @top_result = exec_top_processes rescue nil
      @mem_mb = exec_memory_usage_megabytes rescue nil
    else
      @status = []
    end

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
