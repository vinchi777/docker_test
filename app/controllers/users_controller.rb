class UsersController < AdminController
  load_and_authorize_resource skip_load_resource only: [:create]

  before_action :set_user, except: [:update_password, :change_password]

  def change_password
  end

  def update_password
    @user = current_user

    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render 'change_password'
    end
  end

  # Use this method to whitelist the permissible parameters. Example:
  # params.require(:person).permit(:name, :age)
  # Also, you can specialize this method with per-user checking of permissible attributes.
  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
