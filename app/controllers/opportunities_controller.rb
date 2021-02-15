class OpportunitiesController < ApplicationController
    def show
        @opportunity = Opportunity.find(params[:id])
    end

    def new
        @opportunity = Opportunity.new(company: Company.last)
    end

    def create
        @opportunity = Opportunity.new(allowed_params)
        if @opportunity.save 
            redirect_to @opportunity
        else
            render :new 
        end
    end

    private 
    def allowed_params
        params.require(:opportunity).permit(
            :title,
            :description,
            :requirement,
            :expiration_date,
            :position_quantity,
            :salary,
            :remote,
            :level,
        )
    end

end