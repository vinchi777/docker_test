class ReviewSeasonsController < AdminController
  before_action :set_review_season, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: [:show, :edit , :index, :new]

  def set_page
    @page = 'review-seasons'
  end

  def index
    @review_seasons = ReviewSeason.all
    respond_to do |format|
      format.html { render :index }
    end
  end

  def show
  end

  def new
    @review_season = ReviewSeason.new
  end

  def edit
  end

  def create
    @review_season = ReviewSeason.new(review_season_params)

    respond_to do |format|
      if @review_season.save
        format.html { redirect_to review_seasons_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if  @review_season.update(review_season_params)
        format.html { redirect_to review_seasons_path }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @review_season.destroy
  end

  private
  def set_review_season
    @review_season = ReviewSeason.find(params[:id])
  end

  def review_season_params
    params.require(:review_season).permit(:start, :end, :promoStart, :promoEnd, :repeater, :fullReview, :doubleReview, :coaching, :reservation)
  end
end
