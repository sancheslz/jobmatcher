class OpportunitiesController < ApplicationController
    before_action :authenticate_user!, only: %i[index new create edit update change_visibility application_list application_detail]

    def change_visibility
        @opportunity = Opportunity.find(params[:id])
        @opportunity.change_visibility!
        @opportunity.save
        redirect_to @opportunity.company
    end

    def index 
        @opportunities = get_company_opportunities
    end

    def application_list
        @opportunity = Opportunity.find(params[:id])
    end

    def application_detail
        @submission = Submission.find(params[:id])
    end

    def show
        @opportunity = Opportunity.find(params[:id])
    end

    def new
        @opportunity = Opportunity.new
    end
    
    def create
        @opportunity = Opportunity.new(allowed_params)
        @opportunity.company = current_user.profile.company.first
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

    def get_company_opportunities
        @company = CompanyProfile.find_by(profile: current_user.profile)
        Opportunity.where(company: @company.company)
    end

end