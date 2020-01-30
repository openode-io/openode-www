class Admin::InstancesController < AdminController
  skip_before_action :verify_authenticity_token

  def index
    @instances = {}

    respond_to do |format|
      format.html
      format.json { render json: @instances }
    end
  end

  def edit
    # -
  end

  def access
    # -
  end

  def collaborators
    # -
  end

  def stats
    # -
  end

  def logs
    # -
  end

  def deploy
    sleep(5)

    @status = {
      level: 'success',
      message: 'online',
      icon: 'fa fa-world'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def restart
    sleep(5)

    @status = {
      level: 'success',
      message: 'online',
      icon: 'fa fa-world'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def stop
    sleep(5)

    @status = {
      level: 'critical',
      message: 'stopped',
      icon: 'fa fa-stop'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def delete
    sleep(5)

    @status = {
      level: 'critical',
      message: 'deleted',
      icon: 'fa fa-exclamation-triangle'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end
end
