class LeadsController < ApplicationController
    def index
        if params[:only_converted]
            if params[:only_converted] == "true"
                @leads = Lead.where(is_client: true)
            else
                @leads = Lead.where(is_client: false)
            end
        else
            @leads = Lead.where(is_client: false)
        end

    end

    def new
        @lead = Lead.new
    end

    def create
        @lead = Lead.new new_lead_params
        if @lead.valid?
            @lead.save
            redirect_to :leads
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

    def convert
        lead_ids = params[:leads]
        lead_ids.sub! /^,/, ''
        lead_ids.chomp! ','
        lead_ids = lead_ids.split ','
        leads = Lead.where(id: lead_ids)
        leads.update_all(is_client: true, converted_on: Time.now)
        flash[:notice] = "Selected leads converted successfully"
        redirect_to :leads

    end

    def dashboard
    end


    private
    
    def new_lead_params
        params.require(:lead).permit(
            :first_name, :last_name, :email, :source_id, :stage,
            :description, :estimated_value)
    end
end
