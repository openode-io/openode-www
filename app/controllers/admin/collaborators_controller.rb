class Admin::CollaboratorsController < Admin::InstancesController
  before_action do
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"

    @permissions = make_lister_selection(
      %w[root deploy dns alias storage_area location plan config]
    )
  end

  def index
    add_breadcrumb "Collaborators",
                   admin_instance_collaborators_path,
                   title: "Collaborators"

    @collaborators = api(:get, "/instances/#{@instance_id}/collaborators")
  end

  def new
    add_breadcrumb "Collaborators",
                   admin_instance_collaborators_path,
                   title: "Collaborators"
    add_breadcrumb "New",
                   ''

    @collaborator = OpenStruct.new({})
  end

  def edit
    add_breadcrumb "Collaborators",
                   admin_instance_collaborators_path,
                   title: "Collaborators"
    add_breadcrumb "Collaborator"

    collaborators = api(:get, "/instances/#{@instance_id}/collaborators")
    @collaborator = OpenStruct.new(
      collaborators.find { |c| c['id'].to_s == params['collaborator_id'].to_s }
    )
    @collaborator.email = @collaborator.user['email']
  end

  def update
    api(:patch, "/instances/#{@instance_id}/collaborators/#{params['collaborator_id']}",
        payload: { collaborator: collaborator_params })

    redirect_to({ action: :index }, notice: msg('message.modifications_saved'))
  end

  def create
    api(:post, "/instances/#{@instance_id}/collaborators",
        payload: { collaborator: collaborator_params })

    redirect_to({ action: :index }, notice: "Created!")
  end

  def delete
    api(:delete, "/instances/#{@instance_id}/collaborators/#{params[:collaborator_id]}")

    redirect_to({ action: :index }, notice: "Deleted!")
  end

  protected

  def collaborator_params
    params.require(:collaborator).permit(:email, permissions: [])
  end
end
