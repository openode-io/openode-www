class Admin::InstanceAccessController < Admin::InstancesController
  def index
  end

  def deployments
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Deployments",
                   admin_instance_access_deployments_path,
                   title: "Deployments"
    # -
    @deployments = []
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
