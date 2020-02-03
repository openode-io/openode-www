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

  def create
    sleep(5)

    @status = {
      level: 'success',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def deploy
    sleep(5)

    @status = {
      level: 'warning',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def restart
    sleep(5)

    @status = {
      level: 'warning',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def stop
    sleep(5)

    @status = {
      level: 'warning',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  def delete
    sleep(5)

    @status = {
      level: 'warning',
      message: 'queued'
    }

    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end
end
