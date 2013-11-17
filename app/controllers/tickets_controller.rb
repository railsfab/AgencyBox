class TicketsController < ApplicationController
    #before_filter :authenticate_user!
    #before_filter :admin_employee_auth, only: [:new, :edit, :create, :modify, :tickets]
    before_filter :authenticate_user!


    def index
        @tickets = Ticket.where(assigned_to: current_user)
    end

    def tickets
        @project = Project.find_by_slug params[:project_slug]
        @tickets = @project.tickets
    end

    def new
        @ticket = Ticket.new
        @project = Project.find_by_slug params[:project_slug]
    end

    def edit
        @ticket = Ticket.find params[:id]
        @project = Project.find_by_slug params[:project_slug]
    end

    def create
        @ticket = Ticket.new new_ticket_params
        @ticket.status = "New"
        @ticket.reported_by = current_user
        @ticket.project_id = params[:project_id]
        @ticket.save
        flash[:notice] = "You have created a new ticket '#{new_ticket_params[:name]}'"
        redirect_to ticket_path({ :project_slug => @ticket.project.slug, :id => @ticket })
    end

    def modify
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
        redirect_to ticket_show_path({ :project_slug => @ticket.project.slug, :id => @ticket })
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
        @project = Project.find params[:project_id]
        @project.is_member?(current_user.id) || not_found
    end

end
