class Admin::CollaboratorsController < Admin::InstancesController
  def index
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Collaborators",
                   admin_instance_collaborators_path,
                   title: "Collaborators"

    @doc_link = "/"
    @collaborators = api(:get, "/instances/#{@instance_id}/collaborators")
  end

  def new
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Collaborators",
                   admin_instance_collaborators_path,
                   title: "Collaborators"
    add_breadcrumb "New",
                   ''

    @collaborator_instance = {}
    @permissions = make_lister_selection(
      %w[root deploy dns alias storage_area location plan config]
    )
  end

  def edit
    add_breadcrumb "Instances",
                   admin_instances_path,
                   title: "Instances"
    add_breadcrumb "Collaborators",
                   admin_instance_collaborators_path,
                   title: "Collaborators"
    add_breadcrumb "Collaborator"

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

  def delete
    api(:delete, "/instances/#{@instance_id}/collaborators/#{params[:collaborator_id]}")

    redirect_to({ action: :index }, notice: "Deleted!")
  end

  protected

  def collaborator_params
    params.require(:collaborator).permit(:email, permissions: [])
  end
end
