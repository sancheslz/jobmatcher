class ApplicationController < ActionController::Base
    before_action :user_must_have_profile

    private 
    def user_must_have_profile
        if user_signed_in?

            if (request.original_fullpath != new_profile_path) \
                && (request.original_fullpath != profiles_path && request.method != :post) \
                && !current_user.profile
                redirect_to new_profile_path
            end

        end
    end
end
