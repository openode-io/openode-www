class Admin::InstanceAccessController < Admin::InstancesController
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

  def activity_stream
    add_breadcrumb "Activity Stream",
                   admin_instance_access_activity_stream_path,
                   title: "Activity Stream"

    @events = api(:get, "/instances/#{@instance_id}/events")
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

    @website = get_website
  end

  def cmd
    render json: { msg: "#{params[:cmd]} ran OK." }
  end
end
