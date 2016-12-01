class TasksController < ApplicationController
  before_action :can_access
  before_action :set_task, only: [:show, :edit, :update, :destroy, :destroy_all]
  before_action :require_authentication,
        only: [:show, :edit, :update, :destroy, :new, :create]

  # GET /tasks
  def index
    @tasks = Task.next_semester
  end

  # GET /tasks/1
  def show
    @status = Task.status(@task.id)
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @client = Client.all
    @user = User.all
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.current_user = current_user
    token = SecureRandom.urlsafe_base64

    @client = Client.all
    @user = User.all

    if params[:single_event] == '1'
      @task.single_event = 1
      @task.token = token
      if @task.save
        redirect_to @task, alert: 'success', notice: 'Task (' + task_params[:activity] + ') was successfully created.'
        return
      end
    else
      @task.single_event = 0

      if params[:repeat_end] == 'd'
        begin
           Date.parse(params[:repeat_end_on])
        rescue ArgumentError
          flash[:alert] = 'danger'
          flash[:notice] = 'Date on Repeat End is invalid'
          render :new
          return
        end
      end

      repeat = params[:repeat]
      repeat_start = DateTime.parse(params[:task][:when]) 
      repeat_every = params[:repeat_every]
      repeat_end =  params[:repeat_end] == 'd' ? DateTime.parse(params[:repeat_end_on]) : DateTime.now + 1.year
      tasks = []

      if (repeat_start > repeat_end)
        flash[:alert] = 'danger'
        flash[:notice] = 'When cannot be higher than Repeat End'
        render :new
        return
      end

      if repeat == 'w'

        unless params[:repeat_on].present?
          flash[:alert] = 'danger'
          flash[:notice] = 'You must set at least one Weekday'
          render :new
          return
        end

        day_counter = 0
        week_counter = repeat_every.to_i;
        include_task = true
        weekdays = params[:repeat_on]
        (repeat_start..repeat_end).each do |day|
          if include_task
            if weekdays.include?(day.strftime('%a').downcase)
               repeat_task = Task.new(
                  :user_id => params[:task][:user_id],
                  :client_id => params[:task][:client_id],
                  :when => day,
                  :duration => params[:task][:duration],
                  :single_event => 0,
                  :activity => params[:task][:activity],
                  :comment => params[:task][:comment],
                  :done => 0,
                  :color => params[:task][:color],
                  :token => token
                )
               repeat_task.current_user = current_user
               tasks << repeat_task
            end
          end
          
          day_counter += 1
          if day_counter == 7
            include_task = false
            week_counter -= 1
            day_counter = 0
            if week_counter == 0
              week_counter = repeat_every.to_i
              include_task = true
            end
          end
        end
      else
        months = (repeat_end.year * 12 + repeat_end.month) - (repeat_start.year * 12 + repeat_start.month) - 1
        months_count = (months / repeat_every.to_i).to_i
        
        for i in 0..months_count

          task_when = DateTime.parse(params[:task][:when]) + (i * repeat_every.to_i) .months
          if task_when.next_month.prev_day.strftime('%-d').to_i < task_when.strftime('%-d').to_i
            task_when.change(day: task_when.next_month.prev_day.strftime('%-d').to_i)
          end

          tasks << Task.new(
            :user_id => params[:task][:user_id],
            :client_id => params[:task][:client_id],
            :when => task_when,
            :duration => params[:task][:duration],
            :single_event => 0,
            :activity => params[:task][:activity],
            :comment => params[:task][:comment],
            :done => 0,
            :color => params[:task][:color],
            :token => token
          )
        end
      end
      
      Task.transaction do
        tasks.each(&:save!)
      end

      redirect_to @task, alert: 'success', notice: 'Tasks were successfully created.'
      return

    end
    
    render :new

    #if @task.save
    #  redirect_to @task, alert: 'success', notice: 'Task was successfully created.'
    #else
    #  render :new
    #end
  end
  
  # GET /tasks/1/edit
  def edit
    @client = Client.all
    @user = User.all

    render layout: 'clear'
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, alert: 'success', notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, alert: 'success', notice: 'Task was successfully destroyed.'
  end

  # DELETE /tasks/1/all
  def destroy_all
    repetition = Task.where('`token` = ?', @task.token).where('when >= ?', @task.when)
    repetition.delete_all
    redirect_to tasks_url, alert: 'success', notice: 'All Tasks were successfully destroyed.'
  end

  private
    def can_access
        unless helpers.role_can?
            redirect_to dashboard_path, alert: 'danger', notice: 'You cannot access that area!'
        end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end
7
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params
      .require(:task)
      .permit(:user_id, :client_id, :when, :duration, :single_event, :activity, :comment, :done, :color, :token)
    end
end