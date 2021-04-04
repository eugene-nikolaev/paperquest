class TasksController < ApplicationController
  def show
    @task = Task.find_by_uuid(params[:id])
    if @task.blank?
      @message = "Нет такого задания"
      render template: 'tasks/error'
      return
    end

    @game = @task.game
    prev_pos = @task.position - 1
    if @task.position != 1 && !@game.answered_positions.include?(prev_pos)
      @message = "Сначала пройдите предыдущие задания"
      render template: 'tasks/error'
      return
    end

    new_positions = @game.answered_positions
    new_positions << @task.position
    new_positions = new_positions.uniq
    @game.answered_positions = new_positions
    @game.save
  end
end