class TechnologiesController < ApplicationController
    def index
        @tech = Technology.new
        @technologies = Technology.all.sort_by { |tech| tech.name }
    end

    def edit
        @tech = Technology.find(params[:id])
    end

    def update
        @tech = Technology.find(params[:id])
        data = params.require(:technology).permit(:name)
        @tech.update(data)
        if @tech.save 
            redirect_to technologies_path
        else
            render :edit
        end
    end

    def create 
        @technologies = Technology.all.sort_by { |tech| tech.name }
        @tech = Technology.new(name: params[:name])
        if @tech.save
            redirect_to technologies_path
        else 
            render :index
        end
    end

end