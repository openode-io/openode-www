module Admin::InstanceAccessHelper
  def instance_access_to(instance_id)
    "#{instance_to(instance_id)}access/"
  end
end
