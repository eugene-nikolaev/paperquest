require 'securerandom'

class Admin::GamesController < ApplicationController
  def new; end

  def create
    game_attrs = params[:game] || {}
    name = game_attrs[:name] || ""
    questions_text = game_attrs[:questions] || ""
    questions = questions_text.split(/(\r\n){2,}/).reject { |it| it.strip.empty? }
    if questions.empty?
      flash[:alert] = "No questions"
      render action: :new
    else
      Game.transaction do
        @game = Game.new(
          uuid:    SecureRandom.hex(32),
          pincode: rand(1_000_000_000..9_999_999_999),\
          name:    name,
          text:    questions_text
        )
        @game.answered_positions = []
        @game.save!
        questions.each_with_index do |question, index|
          task = Task.new(
            uuid:     SecureRandom.hex(32),
            game_id:  @game.id,
            position: index + 1,
            question: question
          )
          task.save!
        end
      end
      redirect_to(admin_game_url(@game.uuid))
    end
  end

  def update
    game_attrs = params[:game] || {}
    name = game_attrs[:name] || ""
    questions_text = game_attrs[:text] || ""
    questions = questions_text.split(/(\r\n){2,}/).reject { |it| it.strip.empty? }
    @game = Game.find_by_uuid(params[:id])
    if questions.empty?
      flash[:alert] = "No questions"
      render action: :edit
    else
      Game.transaction do
        @game.update(
          name:    name,
          text:    questions_text
        )
        @game.tasks.delete_all
        questions.each_with_index do |question, index|
          task = Task.new(
            uuid:     SecureRandom.hex(32),
            game_id:  @game.id,
            position: index + 1,
            question: question
          )
          task.save!
        end
      end
      redirect_to(admin_game_url(@game.uuid))
    end
  end

  def edit
    @game = Game.find_by_uuid(params[:id])
  end

  def show
    @game = Game.find_by_uuid(params[:id])
  end

  def print
    @game = Game.find_by_uuid(params[:id])
    @svgs = @game.tasks.map do |task|
      qrcode = RQRCode::QRCode.new(task_url(task.uuid))
      qrcode.as_svg(
        offset: 0,
        color: '000',
        shape_rendering: 'crispEdges',
        module_size: 6,
        standalone: true
      )
    end
  end

  def reset
    @game = Game.find_by_uuid(params[:id])
    if @game.blank?
      flash[:alert] = "No such game"
      redirect_to(admin_path)
    else
      @game.update(
        answered_positions: []
      )
      redirect_to(admin_game_url(@game.uuid))
    end
  end
end