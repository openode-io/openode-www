class Admin::InstanceSettingsController < Admin::InstancesController
  def index
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Settings"
  end

  def plan
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Plan"
  end

  def change_plan
  end

  # DNS and aliases
  def dns_and_aliases
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "DNS & Aliases"

    @website = get_website
    @aliases = [
      "alias.1.com",
      "alias.2.com",
      "alias.3.com"
    ]
  end

  def add_alias
  end

  def remove_alias
  end

  def ssl
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "SSL"
  end

  def scheduler
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Scheduler"
  end

  def persistence
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Persistence"

    @volumes = [
      {
        path: '/path/to/volume/1'
      },
      {
        path: '/path/to/volume/2'
      }
    ]
  end

  def misc
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Misc"
  end
end
