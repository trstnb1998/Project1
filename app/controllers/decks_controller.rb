class DecksController < ApplicationController
  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.new
  end

  def create
    deck = Deck.create deck_params
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])
      deck.image = req["public_id"]
      deck.save
    end
    redirect_to deck_path(deck)
  end

  def edit
    @deck = Deck.find params[:id]
  end

  def update
    deck = Deck.find params[:id]
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])
      deck.image = req["public_id"]
    end
    deck.update_attributes deck_params
    deck.save
    redirect_to deck_path(deck)
  end

  def show
    @deck = Deck.find params[:id]
  end

  def destroy
    deck = Deck.find params[:id]
    deck.destroy
    redirect_to decks_path
  end

  private
  def deck_params
    params.require(:deck).permit(:name, :manufacturer, :size, :price, :image)
  end
end
