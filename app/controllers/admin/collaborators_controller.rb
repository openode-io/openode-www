class Admin::CollaboratorsController < Admin::InstancesController
  def index
    @collaborators = api(:get, "/instances/#{@instance_id}/collaborators")
    puts "colls #{@collaborators.to_json}"
  end
end
