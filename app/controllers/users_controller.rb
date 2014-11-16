class UsersController < AdminController
  before_action :set_user, except: [:index, :create, :update_password, :change_password]

  def index
    @page = 'users'

    respond_to do |format|
      format.html
      format.json { render json: {users: User.all, totalSize: User.all.count} }
    end
  end

  # GET /Users/new
  # GET /Users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(user_params)
    person = Person.new(person_params)
    @user.person = person

    respond_to do |format|
      if person.valid? && @user.valid?
        person.save
        @user.save
        format.json { render json: @user, status: :created, location: @user }
      else
        format.json { render json: {user_errors: @user.errors, person_errors: person.errors}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    own = @user == current_user
    msg = 'You cannot delete your own account.' if own
    msg = 'Cannot delete user. ' unless own
    respond_to do |format|
      if !own &&@user.destroy
        format.json { head :no_content }
      else
        format.json { render json: {message: msg}, status: :unprocessable_entity }
      end
    end
  end

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
    params.require(:user).permit(:current_password, :password, :password_confirmation, :person)
  end

  def person_params
    params.require(:person).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
