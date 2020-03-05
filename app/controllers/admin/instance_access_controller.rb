class Admin::InstanceAccessController < Admin::InstancesController
  def index
    redirect_to({ action: :deployments })
  end

  def deployments
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Deployments",
                   admin_instance_access_deployments_path,
                   title: "Deployments"
    # -
    @deployments = api(:get, "/instances/#{@instance_id}/executions/list/Deployment")

    puts "@deployments #{@deployments.to_json}"
  end

  def activity_stream
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Activity Stream",
                   admin_instance_access_activity_stream_path,
                   title: "Activity Stream"
    # -

    @activities = []
  end

  def console
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Console",
                   admin_instance_access_console_path,
                   title: "Console"

    @website = get_website
  end
end
