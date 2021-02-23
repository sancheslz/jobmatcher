class CompaniesController < ApplicationController
    before_action :authenticate_user!, only: %i[new create edit update change_state]
    before_action :limit_to_user_role!, only: %i[new create edit update change_state]
    before_action :restrict_to_company_members!, only: %i[edit update change_state]

    def show 
        @company = Company.find(params[:id])
        if user_signed_in? && CompanyProfile.find_by(
            company: @company,
            profile: current_user.profile
        )
            @opportunities = Opportunity.where(
                'company_id == ? AND expiration_date > ?',
                "#{params[:id]}",
                0.day.from_now
            )
        else 
            @opportunities = Opportunity.where(
                'company_id == ? AND expiration_date > ? AND is_visible == ?',
                "#{params[:id]}",
                0.day.from_now,
                true
            )
        end
    end

    def new
        @company = Company.new
    end

    def create
        @company = Company.new(allowed_params)
        if @company.save
            CompanyProfile.create!(
                profile: current_user.profile,
                company: @company
            )
            redirect_to @company
        else
            render :new
        end
    end

    def edit
        @company = Company.find(params[:id])
        if @company.active?
            render :edit
        else
            redirect_to root_path
        end
    end

    def update
        @company = Company.find(params[:id])
        @company.update(allowed_params)
        if @company.save
            redirect_to @company
        else
            render :edit
        end
    end

    def change_state
        @company = Company.find(params[:id])
        @company.change_state!
        @company.save
        redirect_to @company
    end

    private 
    def allowed_params 
        params.require(:company).permit(
            :name,
            :cnpj,
            :address,
            :number,
            :complement,
            :neighborhood,
            :city,
            :state,
            :postal_code,
            :website,
            :founded,
            :logo
        )
    end

    def limit_to_user_role!
        if current_user.profile.role == 'regular'
            redirect_to root_path 
        end
    end

    def restrict_to_company_members!
        is_member = CompanyProfile.find_by(
            company: params[:id],
            profile: current_user.profile
        )
        if !is_member
            redirect_to root_path
        end
    end
end