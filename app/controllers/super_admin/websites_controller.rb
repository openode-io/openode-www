class SuperAdmin::WebsitesController < SuperAdminController
  before_action do
    if params['id']
      @website = OpenStruct.new(api(:get, "/instances/#{params['id']}"))
    end
  end

  def index
    search_for = params.dig(:websites_search, :search)
    @websites = api(:get, "/super_admin/websites/?search=#{search_for}")
  end

  def open_source
    @statuses = make_lister_selection(%w[approved rejected pending])
    @open_source = OpenStruct.new(@website.open_source)
  end

  def update_open_source
    api(:post, "/super_admin/websites/#{@website.id}/update_open_source_request",
        payload: { open_source_request: update_open_source_params })

    redirect_to({ action: :open_source }, notice: msg('message.modifications_saved'))
  end

  protected

  def update_open_source_params
    params.require(:open_source).permit(:reason, :status)
  end
end
