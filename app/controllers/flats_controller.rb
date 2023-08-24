class FlatsController < ApplicationController
  before_action :set_flat, only: [:edit, :update, :destroy, :show]

  def index
    @flats = Flat.all
  end

  def new
    @flat = Flat.new
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user

    if @flat.save
      redirect_to flats_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show

  end

  def edit
  end

  def update
    @flat.user = current_user
    if @flat.update(flat_params)
      redirect_to @flats_path, notice: 'Upadated successfully!', status: :see_other
    else
      render :edit
    end
  end

  def destroy
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
