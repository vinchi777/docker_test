class UsersController < AdminController
  before_action :set_user, except: [:index, :new, :create, :update_password, :change_password, :resend_confirmation, :create_student_account]

  layout 'users'

  def index
    @page = 'users'
    q = params[:q]
    page = params[:page]

    respond_to do |format|
      format.html
      format.json do
        if q.nil? || q.blank?
          users = User.asc('email').paginate(page: page, per_page: 10)
          size = User.all.count
        else
          r = User.or({email: /#{q}/i}, {first_name: /#{q}/i}, {last_name: /#{q}/i}).asc('email')
          users = r.paginate(page: page, per_page: 10)
          size = r.length
        end
        render json: {users: users, totalSize: size}
      end
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

  def resend_confirmation
    @user = User.find_by(email: user_params[:email])
    @user.resend_confirmation_instructions

    if @user.update
      render json: @user, status: :created, location: @user
    else
      render json: {user_errors: @user.errors}, status: :unprocessable_entity
    end
  end

  def create_student_account
    s = Student.find(params[:id])
    u = User.new(password: Devise.friendly_token.first(8), person: s)

    if u.save
      render json: u, status: :created, location: u
    else
      render json: {user_errors: u.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    own = @user == current_user
    msg = 'You cannot delete your own account.' if own
    msg = 'Cannot delete user. ' unless own
    respond_to do |format|
      if !own && @user.destroy
        format.json { head :no_content }
      else
        format.json { render json: {message: msg}, status: :unprocessable_entity }
      end
    end
  end

  # Shows own change password html
  def change_password
  end

  # Updates own user password
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

  # Update other user password
  def update_user_password
    respond_to do |format|
      format.json do
        if @user.update_attributes(user_params)
          sign_in @user, bypass: true if @user == current_user
          head :no_content
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # Use this method to whitelist the permissible parameters. Example:
  # params.require(:person).permit(:name, :age)
  # Also, you can specialize this method with per-user checking of permissible attributes.
  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation, :email)
  end

  def person_params
    params.require(:person).permit(:firstName, :middleName, :lastName, :birthdate, :sex, :address, :contactNo, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
