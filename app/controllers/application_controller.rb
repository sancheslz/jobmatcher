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
    
    def limit_to_user_role!
        redirect_to root_path if current_user.profile.role == 'regular'
    end

    def restrict_to_company_members!
        if request.original_fullpath.include?('opportunit')
            opportunity = Opportunity.find(params[:id])
            query = opportunity.company 
        elsif request.original_fullpath.include?('compan')
            query = params[:id]
        end
        is_member = CompanyProfile.find_by(
            :company => query,
            :profile => current_user.profile
        )
        redirect_to root_path unless is_member
    end
end
