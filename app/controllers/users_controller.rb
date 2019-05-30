class UsersController < ApplicationController
  def edit
    @user = current_user
    @states = State.all
    @cities = City.all
  end

  def update
    @user = current_user
    if @user.update(params_user)
      flash[:notice] = 'Perfil atualizado com sucesso!'
      redirect_to user_path(current_user)
    else
      @states = State.all
      @cities = City.all
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    search_param = params[:search]
    return if search_param.blank?

    @users = User.where('email like :search_term OR nickname like :search_term',
                        search_term: "%#{search_param[:q]}%")
  end

  private

  def params_user
    params.require(:user).permit(:name, :state_id, :city_id, :nickname, :avatar)
  end
end
