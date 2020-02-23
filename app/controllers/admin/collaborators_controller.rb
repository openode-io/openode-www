class Admin::CollaboratorsController < Admin::InstancesController
  def index
    @collaborators = api(:get, "/instances/#{@instance_id}/collaborators")
  end

  def new
    @collaborator_instance = {}
    @permissions = make_lister_selection(
      %w[root deploy dns alias storage_area location plan config]
    )
  end

  def create
    api(:post, "/instances/#{@instance_id}/collaborators",
        payload: { collaborator: collaborator_params })

    redirect_to({ action: :index }, notice: "Created!")
  end

  protected

  def collaborator_params
    params.require(:collaborator).permit(:email, permissions: [])
  end
end
