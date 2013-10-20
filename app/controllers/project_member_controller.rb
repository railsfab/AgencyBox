class ProjectMemberController < ApplicationController

    def new
        @project = Project.find_by_slug params[:slug]
        @users = User.all
        @members = @project.members
        @remaining_members = @users - @members
    end

    def create
        @project = Project.find_by_slug params[:slug]
        users = params[:users].split("-")
        @project.add_members users
        redirect_to project_show_path(:slug => @project.slug)
    end
end
