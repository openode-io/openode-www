class Admin::InstanceSettingsController < Admin::InstancesController
  def index
  end

  def plan
  end

  def change_plan
  end

  # DNS and aliases
  def dns_and_aliases
    @website = get_website
  end

  def add_alias
  end

  def remove_alias
  end

  def ssl
  end
end
