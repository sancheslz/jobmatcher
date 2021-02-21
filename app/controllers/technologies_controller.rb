class TechnologiesController < ApplicationController
    before_action :authenticate_user!, only: %i[index new create edit update]
    def index
        @technologies = sorted_by_name
    end
    
    def new 
        @tech = Technology.new
        @technologies = sorted_by_name
    end
    
    def create 
        @technologies = sorted_by_name
        @tech = Technology.new(allowed_params)
        if @tech.save
            redirect_to technologies_path
        else 
            render :new
        end
    end

    def edit
        @tech = Technology.find(params[:id])
        @technologies = sorted_by_name
    end

    def update
        @tech = Technology.find(params[:id])
        @technologies = sorted_by_name
        @tech.update(allowed_params)
        if @tech.save 
            redirect_to technologies_path
        else
            render :edit
        end
    end

    private
    def sorted_by_name
        Technology.all.sort_by do |tech|
            tech.name.upcase
        end
    end

    def allowed_params
        params.require(:technology).permit(
            :name
        )
    end

end