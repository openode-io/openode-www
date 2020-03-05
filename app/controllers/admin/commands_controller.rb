class Admin::CommandsController < AdminController
  def ln
    render json: { msg: 'ln response text' }
  end

  def ls
    render json: { msg: 'ls response text' }
  end

  def cd
    render json: { msg: 'cd response text' }
  end
end
