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

    @plans = api(:get, '/global/available-plans')
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

  def update_scheduler
    api(:patch, "/instances/#{@instance_id}", payload: {
          website: scheduler_params
        })

    redirect_to({ action: :scheduler }, notice: msg('message.modifications_saved'))
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

    @website.max_build_duration = @website.configs['MAX_BUILD_DURATION'] || 100
    @website.skip_port_check = @website.configs['SKIP_PORT_CHECK']
  end

  def update_misc
    params_to_update = misc_params

    api(:post, "/instances/#{@instance_id}/set-config", payload: {
          variable: 'MAX_BUILD_DURATION', value: params_to_update['max_build_duration']
        })

    api(:post, "/instances/#{@instance_id}/set-config", payload: {
          variable: 'SKIP_PORT_CHECK',
          value: ["true", "1", true, 1].include?(params_to_update['skip_port_check'])
        })

    redirect_to({ action: :misc }, notice: msg('message.modifications_saved'))
  end

  protected

  def misc_params
    params.require(:website).permit(:max_build_duration, :skip_port_check)
  end

  def scheduler_params
    params.require(:website).permit(:crontab)
  end
end
