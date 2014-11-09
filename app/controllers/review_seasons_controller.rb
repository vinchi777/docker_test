class ReviewSeasonsController < AdminController
  before_action :set_review_season, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: [:show, :edit, :index, :new]

  def set_page
    @page = 'review-seasons'
  end

  def index
    @review_seasons = ReviewSeason.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @review_seasons }
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
        format.json { render json: @review_season }
      else
        format.json { render json: @review_season.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if  @review_season.update(review_season_params)
        format.json { render json: {status: :ok} }
      else
        format.json { render json: @review_season.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review_season.destroy
    respond_to do |format|
      if @review_season.destroy
        format.json { head :no_content }
      else
        format.json { render status: :unprocessable_entity }
      end
    end
  end

  private
  def set_review_season
    @review_season = ReviewSeason.find(params[:id])
  end

  def review_season_params
    params.require(:review_season).permit(:season, :season_start, :season_end, :promo_start, :promo_end, :first_timer, :repeater, :full_review, :double_review, :coaching, :reservation)
  end
end
