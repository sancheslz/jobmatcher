class ApplicationController < ActionController::Base
    before_action :user_must_have_profile

    private 
    def user_must_have_profile
        if user_signed_in?
            if (request.original_fullpath != destroy_user_session_path \
                && request.method != :delete) 
                @user_profile = current_user.profile

                if  !@user_profile \
                    && (request.original_fullpath != new_profile_path) \
                    && (request.original_fullpath != profiles_path \
                        && request.method != :post)
        
                    redirect_to new_profile_path

                
                elsif  @user_profile && @user_profile.role == 'admin' \
                    && CompanyProfile.find_by(:profile => @user_profile).nil? \
                    && (request.original_fullpath != new_company_path) \
                    && (request.original_fullpath != companies_path \
                        && request.method != :post)
                    
                    redirect_to new_company_path
                end
            end
        end
    end
end
