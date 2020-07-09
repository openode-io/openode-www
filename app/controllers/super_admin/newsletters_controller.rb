class SuperAdmin::NewslettersController < SuperAdminController
  def index
    search_for = params.dig(:newsletters_search, :search)
    @newsletters = api(:get, "/super_admin/newsletters/?search=#{search_for}")
                   .map do |newsletter|
      newsletter['emails_sent'] = newsletter['emails_sent'].count

      newsletter
    end
  end

  def create
    newsletter_values = newsletter_params
    newsletter_values['custom_recipients'] =
      (newsletter_params['custom_recipients'] || '').split(',')

    api(:post, "/super_admin/newsletters/", payload: { newsletter: newsletter_values })

    redirect_to({ action: :index }, notice: "Created!")
  end

  def new
    @recipients_types = make_lister_selection(%w[custom newsletter])
  end

  def deliver
    newsletter_id = params['id']

    api(:post, "/super_admin/newsletters/#{newsletter_id}/send")

    redirect_to({ action: :index }, notice: "Delivered!")
  end

  protected

  def newsletter_params
    params.require(:newsletter)
          .permit(:title, :recipients_type, :content, :custom_recipients)
  end
end
