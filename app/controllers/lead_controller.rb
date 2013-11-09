class LeadController < ApplicationController
    def index
        @leads = Lead.all
    end

    def new
        @lead = Lead.new
    end

    def create
        @lead = Lead.new new_lead_param
        if @lead.valid?
            @lead.save
            redirect_to :lead_index
        else
            render :new
        end
    end

    def show
        @lead = Lead.find params[:id]
    end

    def edit
        @lead = Lead.find params[:id]
    end

    def dashboard
    end


    private
    
    def new_lead_params
        params.require(:lead).permit(
            :first_name, :last_name, :email, :source_id)
    end
end
