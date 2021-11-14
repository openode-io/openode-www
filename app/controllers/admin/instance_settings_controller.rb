class Admin::InstanceSettingsController < Admin::InstancesController
  before_action do
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
  end

  before_action do
    @addons = api(:get, "/instances/#{@instance_id}/addons")
              .sort_by { |a| a&.dig('name') }
              .map { |a| OpenStruct.new(a) }
  end

  before_action do
    if params[:addon_id]
      @addon = OpenStruct.new(
        api(:get, "/instances/#{@instance_id}/addons/#{params[:addon_id]}")
      )
    end
  end

  def index
    redirect_to(action: :plan)
  end

  def plan
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Plan"

    @plans = api(:get, "/instances/#{@website.id}/plans")
    @has_auto_plan = @plans.any? { |p| p['internal_id'] == "auto" }
    @website.blue_green_deployment = @website.configs['BLUE_GREEN_DEPLOYMENT']
    @website.replicas = @website.configs['REPLICAS'] || 1
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

  def address
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Address"
  end

  def change_address
    addr_params = update_address_params

    api(:patch, "/instances/#{@instance_id}/", payload: {
          website: addr_params
        })

    redirect_to({ action: :address }, notice: msg('message.modifications_saved'))
  end

  def location
    add_breadcrumb "Setting", admin_instance_settings_path
    add_breadcrumb "Location"

    @locations = api(:get, "/global/available-locations")
    @website_location = api(:get, "/instances/#{@instance_id}/locations").first
  end

  def change_location
    new_location_str_id = params.dig('website', 'location_str_id')

    # first remove all existing location:
    existing_locations = api(:get, "/instances/#{@instance_id}/locations")

    existing_locations.each do |existing_location|
      api(:post, "/instances/#{@instance_id}/remove-location",
          payload: { location_str_id: existing_location['id'] })
    end

    api(:post, "/instances/#{@instance_id}/add-location",
        payload: { location_str_id: new_location_str_id })

    redirect_to({ action: :location }, notice: msg('message.modifications_saved'))
  end

  # DNS and aliases
  def dns_and_aliases
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "DNS & Aliases"

    @doc_link = "/docs/platform/dns.md"

    @dns = api(:get, "/instances/#{@instance_id}/dns")

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

    @website.ssl_certificate_path = @website.configs['SSL_CERTIFICATE_PATH']
    @website.ssl_certificate_key_path = @website.configs['SSL_CERTIFICATE_KEY_PATH']
  end

  def update_ssl
    params_to_update = update_ssl_params

    api(:post, "/instances/#{@instance_id}/set-config", payload: {
          variable: 'SSL_CERTIFICATE_PATH',
          value: params_to_update['ssl_certificate_path']
        })

    api(:post, "/instances/#{@instance_id}/set-config", payload: {
          variable: 'SSL_CERTIFICATE_KEY_PATH',
          value: params_to_update['ssl_certificate_key_path']
        })

    redirect_to({ action: :ssl }, notice: msg('message.modifications_saved'))
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

  def env
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Environment Variables"

    @doc_link = "/docs/platform/env_vars.md"

    @env = api(:get, "/instances/#{@instance_id}/env_variables")
  end

  def prepare_env_for_update(env_hash)
    env_hash
      .keys
      .filter do |variable|
      variable && env_hash[variable]&.dig('variable')&.present? &&
        env_hash[variable]&.dig('value')&.present?
    end
      .map do |var|
      {
        variable: env_hash[var]['variable'],
        value: env_hash[var]['value']
      }
    end
  end

  def update_env
    new_variable = params.dig('website', 'new_variable')
    new_value = params.dig('website', 'new_value')

    env_hash = (params.dig('website', 'variables') || {})
               .merge(
                 new_variable.to_s => {
                   'variable' => new_variable,
                   'value' => new_value
                 }
               )

    env = prepare_env_for_update(env_hash)

    result_env = {}

    env.each do |e|
      result_env[e[:variable]] = e[:value]
    end

    payload = result_env == {} ? {} : { variables: result_env }

    api(:post, "/instances/#{@instance_id}/env_variables",
        payload: payload)

    redirect_to({ action: :env }, notice: msg('message.modifications_saved'))
  end

  def delete_env
    variable_name = params["variable_name"]

    api(:delete, "/instances/#{@instance_id}/env_variables/#{variable_name}")

    redirect_to({ action: :env }, notice: msg('message.modifications_saved'))
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
    @website.status_probe_path = @website.configs['STATUS_PROBE_PATH'] || '/'
    @website.status_probe_period = @website.configs['STATUS_PROBE_PERIOD'] || 20
    @website.skip_port_check = @website.configs['SKIP_PORT_CHECK']&.include?('true')
  end

  def update_misc
    params_to_update = misc_params

    fields = [
      {
        param_variable: 'max_build_duration',
        internal_variable: 'MAX_BUILD_DURATION'
      },
      {
        param_variable: 'status_probe_path',
        internal_variable: 'STATUS_PROBE_PATH'
      },
      {
        param_variable: 'status_probe_period',
        internal_variable: 'STATUS_PROBE_PERIOD'
      }
    ]

    fields.each do |field|
      api(:post, "/instances/#{@instance_id}/set-config", payload: {
            variable: field[:internal_variable],
            value: params_to_update[field[:param_variable]]
          })
    end

    # special case with skip port check
    api(:post, "/instances/#{@instance_id}/set-config", payload: {
          variable: 'SKIP_PORT_CHECK',
          value: ["true", "1", true, 1].include?(params_to_update['skip_port_check'])
        })

    redirect_to({ action: :misc }, notice: msg('message.modifications_saved'))
  end

  def alerts
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "Alerts"

    @alert_types = api(:get, "/global/type-lists/Website::ALERT_TYPES")

    @alert_types.each do |alert|
      @website.send("#{alert['id']}=", @website&.alerts&.include?(alert['id']))
    end
  end

  def update_alerts
    alerts = []

    params['website'].each do |k, v|
      alerts << k if v == '1'
    end

    api(:patch, "/instances/#{@instance_id}/",
        payload: {
          website: {
            alerts: alerts
          }
        })

    redirect_to({ action: :alerts }, notice: msg('message.modifications_saved'))
  end

  # addons!
  def new_addon
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "#{@addon&.name || 'New'} Addon"

    @available_addons = api(:get, "/global/addons")
  end

  def create_addon
    result = api(:post, "/instances/#{@instance_id}/addons/",
                 payload: { 'addon' => create_addon_params })

    redirect_to({ action: :edit_addon, addon_id: result['id'] },
                notice: msg('message.modifications_saved'))
  end

  def edit_addon
    add_breadcrumb "Settings",
                   admin_instance_settings_path
    add_breadcrumb "#{@addon.name} Addon"

    readme_file = @addon.addon.dig('obj', 'documentation_filename')
    url_readme = "#{@addon.addon['repository_root_file_url']}/#{readme_file}"

    @readme = RestClient::Request.execute(method: :get, url: url_readme)

    docker_url_tags =
      "https://registry.hub.docker.com/v1/repositories" \
      "/#{@addon.addon.dig('obj', 'image')}/tags"
    all_tags = JSON.parse(
      RestClient::Request.execute(method: :get, url: docker_url_tags).to_s
    )
    @tags = all_tags.map { |tag| tag['name'] }

    @plans = api(:get, '/global/available-plans')
             .reject { |p| %w[open-source auto].include?(p['internal_id']) }
  end

  def update_addon
    api(:patch, "/instances/#{@instance_id}/addons/#{@addon.id}",
        payload: { 'addon' => update_addon_params })

    redirect_to({ action: :edit_addon }, notice: msg('message.modifications_saved'))
  end

  def destroy_addon
    api(:delete, "/instances/#{@instance_id}/addons/#{@addon.id}")

    redirect_to({ action: :index }, notice: msg('message.modifications_saved'))
  end

  protected

  def alias_params
    params.require(:alias).permit(:alias)
  end

  def misc_params
    params.require(:website).permit(:max_build_duration,
                                    :status_probe_path,
                                    :status_probe_period,
                                    :skip_port_check)
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
    params.require(:website).permit(:plan,
                                    :blue_green_deployment,
                                    :replicas,
                                    :open_source_title,
                                    :open_source_repository,
                                    :open_source_description)
  end

  def update_address_params
    params.require(:website).permit(:site_name)
  end

  def create_addon_params
    params.require(:addon).permit(:addon_id)
  end

  def update_addon_params
    params.require(:addon).permit(:account_type, :addon_id, :name, :storage_gb, obj: {})
  end

  def update_ssl_params
    params.require(:website).permit(:ssl_certificate_path, :ssl_certificate_key_path)
  end
end
