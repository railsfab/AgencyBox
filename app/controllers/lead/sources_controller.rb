class Lead::SourcesController < ApplicationController
    def new
        @source = LeadSource.new
    end

    def create
        @source = LeadSource.new source_params
        if @source.valid?
            @source.save
            redirect_to lead_sources_path()
        else
            render :new
        end
    end

    def index
        @sources = LeadSource.all
    end

    def show
        @source = LeadSource.find params[:id]
    end

    def edit
        @source = LeadSource.find params[:id]
    end

    def update
        @source = LeadSource.find params[:id]
        if @source.update(source_params)
            redirect_to @source
        else
            render :edit
        end
    end

    def delete_multiple
        deletable = params[:source][:id]
        LeadSource.delete_all id: deletable
        flash[:notice] = "Deleted selected lead sources successfully"
        redirect_to :lead_sources
    end


    private

    def source_params
        params.require(:lead_source).permit(:name)
    end

end
