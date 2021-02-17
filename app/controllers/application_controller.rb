class ApplicationController < ActionController::Base
    before_action :user_must_have_profile

    private 
    def user_must_have_profile
        if user_signed_in?

            if  !current_user.profile \
                && (request.original_fullpath != new_profile_path) \
                && (request.original_fullpath != profiles_path && request.method != :post)
    
                redirect_to new_profile_path

            elsif  current_user.profile \
                && current_user.profile.role == 'admin' \
                && CompanyProfile.find_by(profile: current_user.profile).nil? \
                && (request.original_fullpath != new_company_path) \
                && (request.original_fullpath != companies_path && request.method != :post)
                
                redirect_to new_company_path
            end

        end
    end
end
