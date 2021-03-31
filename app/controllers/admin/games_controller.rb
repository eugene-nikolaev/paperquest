class Admin::GamesController < ApplicationController
  def new
   
  end

  def create
    game_attrs = params[:game] || {}
    name = game_attrs[:name] || ""
    questions_text = game_attrs[:questions] || ""
    questions = questions_text.split(/(\r\n){2,}/).reject { |it| it.strip.empty? }
    if questions.empty?
      flash[:error] = "No questions"
    else
      Game.transaction do
        game = Game.new(
          pincode: rand(1_000_000_000..9_999_999_999),\
          name:    name
        )
        game.save!
        questions.each_with_index do |question, index|
          task = Task.new(
            game_id: game.id,
            position: index + 1,
            question: question
          )
          task.save!
        end
      end
    end
  end

  def edit

  end

  def show

  end
end