class Admin::InstancesController < AdminController
  skip_before_action :verify_authenticity_token,
                     only: [:index, :create, :deploy, :stop, :delete]

  before_action do
    if params['id']
      @instance_id = params['id']
      @website = OpenStruct.new(api(:get, "/instances/#{@instance_id}"))
    end

    @doc_link = "/docs/platform/"
  end

  def index
    respond_to do |format|
      format.html do
        my_instances_summary = instances_summary

        if my_instances_summary.count == 1 &&
           !my_instances_summary.first['last_deployment_id']
          first_instance = my_instances_summary.first
          @tips = "<a href=\"/admin/instances/#{first_instance['id']}/access\">" \
                  "Deploy your instance >></a>"
        end
      end
      format.json { render json: instances_summary }
    end
  end

  def plans
    user = OpenStruct.new(api(:get, "/account/me"))

    plans = api(:get, '/global/available-plans/gcloud_run').select do |plan|
      if plan['internal_id'] == "auto"
        user.has_active_subscription
      else
        true
      end
    end

    json(plans)
  end

  def available_locations
    json(api(:get, "/global/available-locations?type=#{params['type']}"))
  end

  def collaborators
    # -
  end

  def stats
    # -
  end

  def logs
    # -
  end

  def credits
    # -
  end

  def create
    api(:post, '/instances/create', payload: instance_params.merge(openode_version: "v3"))

    @status = {
      level: 'success',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def deploy
    path_executions = "/instances/#{@instance_id}/executions/list" \
                      "/Deployment/?status=success"
    latest_exec = api(:get, path_executions).first

    @status = {
      level: 'warning',
      message: 'queued'
    }

    if latest_exec
      path_restart = "/instances/#{@instance_id}/restart" \
                      "?parent_execution_id=#{latest_exec['id']}"

      api(:post, path_restart)
    else
      @status = {
        level: 'warning',
        message: "No latest image available. Use the CLI to deploy your instance."
      }
    end

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def stop
    api(:post, "/instances/#{@instance_id}/stop")

    @status = {
      level: 'warning',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def delete
    api(:delete, "/instances/#{@instance_id}")

    @status = {
      level: 'warning',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  private

  def status_to_level(status)
    {
      'online' => 'success',
      'N/A' => 'critical',
      'starting' => 'warning'
    }[status]
  end

  def status_to_message(status)
    {
      'online' => 'online',
      'N/A' => 'offline',
      'starting' => 'launching'
    }[status]
  end

  def instances_summary
    api(:get, '/instances/summary')
      .map do |instance|
      orig_status = instance['status']

      instance['status'] = {
        'level' => status_to_level(orig_status),
        'message' => status_to_message(orig_status)
      }

      instance['plan'] ||= {}

      instance
    end
  end

  def get_website
    @website = api(:get, "/instances/#{@instance_id}/")
  end

  def instance_params
    params.require(:instance).permit(:account_type, :location,
                                     :domain_type, :site_name, :domains,
                                     :open_source_description, :open_source_repository,
                                     :open_source_title)
  end
end
