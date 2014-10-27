class AdminController < ApplicationController
  layout 'layouts/admin'

  before_action :authenticate_user!
end