class Admin::PagesController < ApplicationController
  def index; end

  def search
  	game_attrs = params[:game] || {}
		@game = Game.find_by_pincode(game_attrs[:pincode])
		if @game.blank?
			flash[:alert] = "No such game"
			redirect_to admin_path
		else
			redirect_to admin_game_path(@game.uuid)
		end  	
  end
end