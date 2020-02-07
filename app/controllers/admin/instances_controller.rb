class Admin::InstancesController < AdminController
  skip_before_action :verify_authenticity_token

  def index
    respond_to do |format|
      format.html
      format.json { render json: instances_summary }
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

  private

  def status_to_level(status)
    {
      'online' => 'success',
      'N/A' => 'critical',
      'starting' => 'warning'
    }[status]
  end

  def status_to_message(status)
    {
      'online' => 'online',
      'N/A' => 'offline',
      'starting' => 'launching'
    }[status]
  end

  def instances_summary
    api(:get, '/instances/summary')
      .map do |instance|
      orig_status = instance['status']
      instance['status'] = {
        'level' => status_to_level(orig_status),
        'message' => status_to_message(orig_status)
      }

      instance['plan'] ||= {}

      instance
    end
  end
end
