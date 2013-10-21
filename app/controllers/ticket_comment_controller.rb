class TicketCommentController < ApplicationController
    before_filter :authenticate_user!

    def create
        @ticket = Ticket.find params[:ticket_id]
        content = "#{params[:@ticket_comment][:content]}"
        @ticket_comment = TicketComment.new(content: content, ticket_id: params[:ticket_id], created_by: current_user)
        if @ticket_comment.valid?
            @ticket_comment.save
            redirect_to ticket_show_path(project_slug: @ticket.project.slug, id: params[:ticket_id])
        else
            render ticket_show_path(project_slug: @ticket.project.slug, ticket_id: params[:ticket_id])
        end
    end

end
