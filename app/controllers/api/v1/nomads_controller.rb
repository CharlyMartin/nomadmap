class Api::V1::NomadsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Nomad, only: [ :update ]
  before_action :set_nomad, only: [ :show, :update ]

  def index
    @nomads = Nomad.all
  end

  def show
  end

  def update
    if @nomad.update(latitude: nomad_params[:latitude], longitude: nomad_params[:longitude], latest_chrome_update: Time.zone.now)
      render :show
    else
      render_error
    end
  end

  private

  def set_nomad
    @nomad = Nomad.find_by(username: params[:id])
  end

  def nomad_params
    params.require(:nomad).permit(:latitude, :longitude)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
    status: :unprocessable_entity
  end
end
