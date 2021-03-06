class Project::TicketsController < ApplicationController
    #before_filter :authenticate_user!
    #before_filter :admin_employee_auth, only: [:new, :edit, :create, :modify, :tickets]
    before_filter :authenticate_user!


    def tickets
        @tickets = Ticket.where(assigned_to: current_user)
    end

    def index
        @project = Project.find_by_slug params[:namespace_slug]
        @tickets = @project.tickets
    end

    def new
        @ticket = Ticket.new
        @project = Project.find_by_slug params[:namespace_slug]
        @project_members = @project.get_members
        if @project_members.empty?
            flash[:notice] = "Please add members to the project before using tickets"
            redirect_to add_project_members_path(slug: @project.slug)
        end
    end

    def edit
        @ticket = Ticket.find params[:id]
        @project = Project.find_by_slug params[:namespace_slug]
    end

    def create
        @ticket = Ticket.new new_ticket_params
        @ticket.status = "New"
        @ticket.reported_by = current_user
        @ticket.project_id = params[:namespace_id]
        @ticket.save
        flash[:notice] = "You have created a new ticket '#{new_ticket_params[:name]}'"
        redirect_to project_ticket_path({ :namespace_slug => @ticket.project.slug, :id => @ticket })
    end

    def update 
        @ticket = Ticket.find params[:id]
        @ticket.assign_attributes edit_ticket_params
        changed = @ticket.changed

        #Create comment when a ticket is modified
        comment = TicketComment.new
        content = "changed "
        changed.each do |changed_item|
            if changed_item == "assigned_to_id"
                assigned_to_was = User.find @ticket.assigned_to_id_was
                content += "<span class='ticket_changed_field_name'>assigned to</span> from <span class='ticket_changed_from'>#{assigned_to_was.available_name}</span> to <span class='ticket_changed_to'>#{@ticket.assigned_to.available_name}</span>, "
            else
                content += "<span class='ticket_changed_field_name'>#{changed_item}</span> from <span class='ticket_changed_from'>#{@ticket.send(changed_item+"_was")}</span> to <span class='ticket_changed_to'>#{@ticket[changed_item]}</span>, "
            end
        end
        if changed.any? 
            content = content.strip.chomp(",")
            TicketComment.create(ticket: @ticket, content: content, created_by: current_user)
        end

        @ticket.save
        redirect_to project_ticket_path({ :namespace_slug => @ticket.project.slug, :id => @ticket })
    end

    def show
        @ticket = Ticket.find params[:id]
        @ticket_comment = TicketComment.new
    end

    private

    def new_ticket_params
        params.require(:ticket).permit(:name, :description, :assigned_to_id)
    end

    def edit_ticket_params
        params.require(:ticket).permit(:name, :description, :assigned_to_id, :status)
    end

    def admin_employee_auth
        @project = Project.find params[:namespace_id]
        @project.is_member?(current_user.id) || not_found
    end

end
