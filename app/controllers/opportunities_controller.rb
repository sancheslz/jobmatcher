class OpportunitiesController < ApplicationController

    def change_visibility
        @opportunity = Opportunity.find(params[:id])
        @opportunity.change_visibility!
        @opportunity.save
        redirect_to @opportunity.company
    end

    def show
        @opportunity = Opportunity.find(params[:id])
    end

    def new
        @opportunity = Opportunity.new
    end
    
    def create
        @opportunity = Opportunity.new(allowed_params)
        @opportunity.company = curent_user.profile.company
        if @opportunity.save 
            redirect_to @opportunity
        else
            render :new 
        end
    end

    def edit
        @opportunity = Opportunity.find(params[:id])
    end

    def update
        @opportunity = Opportunity.find(params[:id])
        @opportunity.update(allowed_params)
        if @opportunity.save 
            redirect_to company_path(@opportunity.company)
        else
            render :edit 
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