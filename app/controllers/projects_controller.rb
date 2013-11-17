class ProjectsController < ApplicationController
    before_filter :authenticate_user!

    
    def new
        @project = Project.new
    end

    def create
        @project = Project.new new_project_params
        if @project.valid?
            @project.created_by = current_user
            @project.save
            redirect_to project_show_path(slug: @project.slug)
        else
            render :new
        end
    end

    def edit
        @project = Project.find_by_slug params[:slug]
    end

    def update
        @project = Project.find_by_slug params[:slug]
        @project.assign_attributes new_project_params
        
        if @project.valid?
            @project.save
            redirect_to project_show_path(slug: @project.slug)
        else
            render :edit
        end
    end

    def show
        @project = Project.find_by slug: params[:slug]
    end

    def index
        @projects = Project.where created_by: current_user
    end

    private

    def new_project_params
        params.require(:project).permit(:name, :description)
    end

end
