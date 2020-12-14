class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authenticate_user! # GET /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @task = @project.tasks.build
  end

  # GET /projects/new
  def new
    @project = current_user.projects.build
  end

  # GET /projects/1/edit
  def edit; end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html do
          redirect_to @project, notice: 'Project was successfully created.'
        end
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json do
          render json: @project.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html do
          redirect_to @project, notice: 'Project was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json do
          render json: @project.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html do
        redirect_to projects_url, notice: 'Project was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = current_user.projects.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :description)
  end
end
