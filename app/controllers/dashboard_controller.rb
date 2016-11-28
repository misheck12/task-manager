class DashboardController < ApplicationController
  before_action :require_authentication,
                only: [:show]

  def show
    @tasks = Task.next_year.user(current_user.id)
    @tasks_done = Task.last_week.done.user(current_user.id)
    @tasks_week = Task.next_week.pending.user(current_user.id).old_first
    @tasks_late = Task.last_year.pending.user(current_user.id).old_first
  end
end
