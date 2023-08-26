class FlatsController < ApplicationController
  before_action :set_flat, only: [:edit, :update, :destroy, :show]

  def index
    @flats = policy_scope(Flat)
    #authorize @flat
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    authorize @flat

    if @flat.save
      redirect_to flats_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    authorize @flat
  end

  def edit
    authorize @flat
  end

  def update
    authorize @flat
    @flat.user = current_user
    if @flat.update(flat_params)
      redirect_to @flats_path, notice: 'Upadated successfully!', status: :see_other
    else
      render :edit
    end
  end

  def destroy
    authorize @flat
    @flat.destroy
    redirect_to root_path, notice: 'Flat was successfully destroyed!', status: :see_other
  end

  private

  def flat_params
    params.require(:flat).permit(:name, :description, :price, :address)
  end

  def set_flat
    @flat = Flat.find(params[:id])
  end
end
