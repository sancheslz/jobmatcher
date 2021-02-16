class CompaniesController < ApplicationController

    def show 
        @opportunities = Opportunity.where(
            company_id: params[:id],
            is_visible: true
        )
        @company = Company.find(params[:id])
    end

    def new
        @company = Company.new
    end

    def create
        @company = Company.new(allowed_params)
        if @company.save
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
        )
    end
end