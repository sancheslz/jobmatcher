class ProfilesController < ApplicationController

    def show
        @profile = Profile.find(params[:id])
    end

    def new
        @profile = Profile.new
    end

    def create
        @profile = Profile.new(allowed_params)
        if @profile.save
            redirect_to @profile 
        else 
            render :new
        end
    end

    private 
    def allowed_params
        params.require(:profile).permit(
            :name,
            :cpf,
            :bio,
            :address,
            :number,
            :complement,
            :neighborhood,
            :city,
            :state,
            :postal_code,
        )
    end
end