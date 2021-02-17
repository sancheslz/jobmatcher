class ProfilesController < ApplicationController

    def show
        @profile = Profile.find_by(user: current_user)
    end

    def new
        @profile = Profile.new
    end

    def create
        @profile = Profile.new(allowed_params)
        @profile.user = current_user
        @profile.set_role!(current_user)
        if @profile.save
            redirect_to root_path
        else 
            render :new
        end
    end

    def edit 
        @profile = Profile.find_by(user: current_user)
    end

    def update
        @profile = Profile.find_by(user: current_user)
        @profile.update(allowed_params)
        if @profile.save
            redirect_to @profile 
        else 
            render :edit
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