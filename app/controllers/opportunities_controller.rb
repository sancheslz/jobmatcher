class OpportunitiesController < ApplicationController
    before_action :authenticate_user!, only: %i[index new create edit update change_visibility application_list application_detail]
    before_action :limit_to_user_role!, only: %i[new create edit update change_visibility]
    before_action :restrict_to_company_members!, only: %i[ change_visibility  application_list edit  update]

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
        @submissions = @opportunity.submissions.where(
            'status <> ?',
            90 # Submission => :removed = 90
        )
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
            technology_ids: []
        )
    end

    def get_company_opportunities
        @company = CompanyProfile.find_by(profile: current_user.profile)
        Opportunity.where('company_id == ? AND expiration_date > ? AND is_visible == ?',
            @company.company,
            "#{0.day.from_now}",
            true
        )
    end

    def limit_to_user_role!
        if current_user.profile.role == 'regular'
            redirect_to root_path 
        end
    end

    def restrict_to_company_members!
        opportunity = Opportunity.find(params[:id])
        is_member = CompanyProfile.find_by(
            company: opportunity.company,
            profile: current_user.profile
        )
        unless is_member
            redirect_to root_path
        end
    end

end