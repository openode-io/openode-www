class Admin::InstancesController < AdminController
  skip_before_action :verify_authenticity_token,
                     only: [:index, :create, :deploy, :stop, :delete]

  before_action do
    if params['id']
      @instance_id = params['id']
      @website = OpenStruct.new(api(:get, "/instances/#{@instance_id}"))
    end
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: instances_summary }
    end
  end

  def plans
    json(api(:get, '/global/available-plans'))
  end

  def available_locations
    json(api(:get, "/global/available-locations?type=#{params['type']}"))
  end

  def access
    add_breadcrumb "instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Access",
                   admin_instance_access_path,
                   title: "Access"
    # -
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
    api(:post, '/instances/create', payload: instance_params)

    @status = {
      level: 'success',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def deploy
    sleep(5)

    @status = {
      level: 'warning',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def stop
    sleep(5)

    @status = {
      level: 'warning',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def delete
    sleep(5)

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
                                     :domain_type, :site_name, :domains)
  end
end
