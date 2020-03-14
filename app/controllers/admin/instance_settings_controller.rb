class Admin::InstanceSettingsController < Admin::InstancesController
  before_action do
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
  end

  def index
    redirect_to({ action: :plan })
  end

  def plan
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Plan"

    @plans = api(:get, '/global/available-plans')
    @website.open_source = @website.open_source || {}
  end

  def change_plan
    new_plan_params = update_plan_params

    if new_plan_params['plan'] == "open_source"
      api(:patch, "/instances/#{@instance_id}",
          payload: {
            website: {
              open_source: {
                title: new_plan_params['open_source_title'],
                description: new_plan_params['open_source_description'],
                repository_url: new_plan_params['open_source_repository']
              }
            }

          })
    end

    if new_plan_params['plan'] != @website.account_type
      api(:post, "/instances/#{@instance_id}/set-plan",
          payload: { plan: new_plan_params['plan'] })
    end

    redirect_to({ action: :plan }, notice: msg('message.modifications_saved'))
  end

  # DNS and aliases
  def dns_and_aliases
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "DNS & Aliases"

    @aliases = (@website.domains || []).reject { |domain| domain == @website.site_name }
  end

  def add_alias
    api(:post, "/instances/#{@instance_id}/add-alias",
        payload: { hostname: alias_params['alias'] })

    redirect_to({ action: :dns_and_aliases }, notice: msg('message.modifications_saved'))
  end

  def remove_alias
    decoded_alias = Base64.decode64(params['domain'])

    api(:post, "/instances/#{@instance_id}/del-alias",
        payload: { hostname: decoded_alias })

    redirect_to({ action: :dns_and_aliases }, notice: msg('message.modifications_saved'))
  end

  def ssl
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "SSL"

    @doc_link = "/docs/platform/ssl.md"
  end

  def scheduler
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Scheduler"

    @doc_link = "/docs/platform/scheduler_cron_jobs.md"
  end

  def update_scheduler
    api(:patch, "/instances/#{@instance_id}", payload: {
          website: scheduler_params
        })

    redirect_to({ action: :scheduler }, notice: msg('message.modifications_saved'))
  end

  def persistence
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Persistence"

    @storage = api(:get, "/instances/#{@instance_id}/storage")
    @doc_link = "/docs/platform/persistence.md"
  end

  def destroy_persistence
    api(:post, "/instances/#{@instance_id}/destroy-storage")

    redirect_to({ action: :persistence }, notice: msg('message.modifications_saved'))
  end

  def change_size
    storage = api(:get, "/instances/#{@instance_id}/storage")

    existing_size = storage['extra_storage']&.to_i
    new_size = change_size_params['amount_gb']&.to_i

    change_size = new_size - existing_size

    api(:post, "/instances/#{@instance_id}/increase-storage",
        payload: { amount_gb: change_size })

    redirect_to({ action: :persistence }, notice: msg('message.modifications_saved'))
  end

  def create_storage_area
    api(:post, "/instances/#{@instance_id}/add-storage-area",
        payload: storage_area_params)

    redirect_to({ action: :persistence }, notice: msg('message.modifications_saved'))
  end

  def destroy_storage_area
    storage_area = Base64.decode64(params[:b64volume])

    api(:post, "/instances/#{@instance_id}/del-storage-area",
        payload: { storage_area: storage_area })

    redirect_to({ action: :persistence }, notice: msg('message.modifications_saved'))
  end

  def misc
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Misc"

    @doc_link = "/docs/misc/index.md"

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

  def alias_params
    params.require(:alias).permit(:alias)
  end

  def misc_params
    params.require(:website).permit(:max_build_duration, :skip_port_check)
  end

  def scheduler_params
    params.require(:website).permit(:crontab)
  end

  def change_size_params
    params.require(:persistence).permit(:amount_gb)
  end

  def storage_area_params
    params.require(:persistence).permit(:storage_area)
  end

  def update_plan_params
    params.require(:website).permit(:plan, :open_source_title, :open_source_repository,
                                    :open_source_description)
  end
end
