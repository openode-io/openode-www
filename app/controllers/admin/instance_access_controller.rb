class Admin::InstanceAccessController < Admin::InstancesController
  skip_forgery_protection only: [:cmd]

  before_action do
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    @website_summary = api(:get, "/instances/#{@website.id}/summary")
  end

  def index
    redirect_to(action: :deploy)
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

    @app = params[:app] || "www"

    @addons = api(:get, "/instances/#{@instance_id}/addons/")

    @paths = snapshot_paths_for(@website, @app)
  end

  def snapshot_paths_for(website, app)
    if app == "www"
      snapshot_paths_for_www(website, app)
    else
      snapshot_paths_for_addon(website, app)
    end
  end

  def snapshot_paths_for_www(website, _app)
    workdir = if website.status == 'online'
                result = api(:post, "/instances/#{website.id}/cmd",
                             payload: {
                               cmd: 'pwd',
                               app: 'www'
                             })

                result.dig('result', 'stdout')&.strip
    end

    (workdir ? [{ path: "Workdir (#{workdir})", id: workdir }] : []) +
      (website.storage_areas || []).map do |storage_area|
        {
          path: "Storage area (#{storage_area})",
          id: storage_area
        }
      end
  end

  def snapshot_paths_for_addon(_website, app)
    addon = @addons.find { |a| a['name'] == app }

    requires_persistence = addon.dig('addon', 'obj', 'requires_persistence')
    persistent_path = addon.dig('obj', 'persistent_path')

    requires_persistence ? [{ path: persistent_path, id: persistent_path }] : []
  end

  def create_snapshot
    path = params.dig('website', 'path')
    app = params.dig('website', 'app')

    api(:post, "/instances/#{@instance_id}/snapshots",
        payload: { path: path, app: app })

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

  def deploy
    add_breadcrumb "Deploy",
                   admin_instance_access_deploy_path,
                   title: "Deploy"
    @doc_link = "/docs/platform/deploy.md"
  end

  def do_deploy
    repository_url = params.dig('website', 'repository_url')

    api(:post, "/instances/#{@instance_id}/scm-clone",
        payload: { repository_url: repository_url })

    result = api(:post, "/instances/#{@instance_id}/restart",
                 payload: { repository_url: repository_url })

    redirect_to({
                  action: :deployment,
                  deployment_id: result['deploymentId']
                },
                notice: "Deployment in progress...")
  end

  def one_click_app
    add_breadcrumb "Deploy One Click App",
                   admin_instance_access_deploy_path,
                   title: "Deploy"
    @doc_link = "/docs/platform/deploy.md"
    @one_click_apps = api(:get, "/global/type-lists/OneClickApps")
  end

  def create_one_click_app
    app_id = params['website']['one_click_app_id']

    raise "No selected app" unless app_id

    api(:post,
        "/instances/#{@instance_id}/prepare-one-click-app",
        payload: { one_click_app_id: app_id })

    redirect_to({
                  action: :configure_one_click_app
                },
                notice: "Initialized One Click App")
  end

  def configure_one_click_app
    add_breadcrumb "Deploy",
                   admin_instance_access_deploy_path,
                   title: "Deploy"
    @doc_link = "/docs/platform/deploy.md"

    app_id = @website.one_click_app['id']

    all_apps = api(:get, "/global/type-lists/OneClickApps")

    app = all_apps.find { |a| a["id"].to_s == app_id.to_s }
    @app_name = app['config']['name']

    @versions = retrieve_docker_tags(app['config']['image'])
    @version = @website.one_click_app&.dig('version') || "latest"
  end

  def update_one_click_app
    api(:patch,
        "/instances/#{@instance_id}/one-click-app",
        payload: { attributes: params[:website][:one_click_app] })

    app_id = @website.one_click_app['id']
    result = api(:post, "/instances/#{@instance_id}/restart?template=#{app_id}")

    redirect_to({
                  action: :deployment,
                  deployment_id: result['deploymentId']
                },
                notice: "Deployment in progress...")
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
                   cmd: cmd,
                   app: 'www'
                 })
    result.dig('result', 'stdout')
          .lines
          .reject { |line| line.include?(cmd) } [3..]
          .join
  end

  def status
    add_breadcrumb "Status",
                   admin_instance_access_status_path,
                   title: "Status"

    @status = api(:get, "/instances/#{@instance_id}/status")

    @top_result = ""

    if @website.status == 'online'
      @top_result = exec_top_processes rescue nil
    else
      @status = []
    end
  end

  def get_service_stat(service_name, stat_name, stat)
    stat.map do |s|
      cur_s = s['obj'].find { |service_s| service_s['service'] == service_name }

      if cur_s
        {
          "value" => cur_s[stat_name],
          "date" => s['created_at']
        }
      else
        {}
      end
    end
    .select do |s|
      s && s["date"].present? && s["value"].present?
    end
  end

  def resources_usage
    add_breadcrumb "Status",
                   admin_instance_access_resources_usage_path,
                   title: "Resources Usage"

    stat = api(:get, "/instances/#{@instance_id}/stats/mem_cpu")
    @services = []

    if stat.count.positive?
      @service_names = stat.first['obj'].map { |s| s['service'] }

      @services = @service_names.map do |service_name|
        stat_cpu = get_service_stat(service_name, "cpu", stat)
                   .map do |s|
          if s['value']
            s['value'] *= 100.0
          end

          s
        end

        stat_memory = get_service_stat(service_name, "memory", stat)

        {
          name: service_name,
          stat_cpu: stat_cpu,
          stat_memory: stat_memory
        }
      end
    end

    @stats_cpu = []
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
      api(:post, "/instances/#{@instance_id}/cmd", payload: { cmd: cmd, app: 'www' })
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
