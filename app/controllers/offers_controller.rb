class OffersController < ApplicationController

    def show 
        @offer = Offer.find(params[:id])
        if current_user != @offer.submission.profile.user
            redirect_to submissions_path
        end
    end

    def deny_create
        allowed_params = params.require(:offer).permit(:comment)
        
        @offer = Offer.new(allowed_params)
        @submission = Submission.find(params[:submission])
        @offer.submission = @submission
        @offer.profile = current_user.profile

        if @offer.save
            @submission.update(:status => :denied)
            @submission.save
            redirect_to application_list_opportunity_path(
                @submission.opportunity.id
            ) 
        else 
            render :deny, :submission => @submission
        end
    end
    
    def accept_create
        allowed_params = params.require(:offer).permit(
            :salary,
            :comment,
            :start_at
        )
    
        @offer = Offer.new(allowed_params)
        @submission = Submission.find(params[:submission])
        @offer.submission = @submission
        @offer.profile = current_user.profile
        
        if @offer.save(:context => :accept)
            @submission.update(:status => :accepted)
            @submission.save
            redirect_to application_list_opportunity_path(
                @submission.opportunity.id
            ) 
        else 
            render :accept, :submission => @submission
        end
    end

    def accept 
        @submission = Submission.find(params[:submission])
        @offer = Offer.new
    end

    def deny 
        @submission = Submission.find(params[:submission])
        @offer = Offer.new
    end

    def candidate_accept
        @offer = Offer.find(params[:id])
        submission = @offer.submission
        submission.update(:status => :hired)
        submission.save
        redirect_to submissions_path
    end

    def candidate_deny
        @offer = Offer.find(params[:id])
        submission = @offer.submission
        submission.update(:status => :refused)
        submission.save
        redirect_to submissions_path
    end

end
