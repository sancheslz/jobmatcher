class OffersController < ApplicationController

    def deny_create
        allowed_params = params.require(:offer).permit( :comment )
        
        @offer = Offer.new(allowed_params)
        @submission = Submission.find(params[:submission])
        @offer.submission = @submission
        @offer.profile = current_user.profile

        if @offer.save 
            @submission.status = :denied
            @submission.save(context: :deny)
            redirect_to application_list_opportunity_path(@submission.opportunity.id) 
        else 
            render :deny, submission: @submission
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
        
        if @offer.save(context: :accept)
            redirect_to application_list_opportunity_path(@submission.opportunity.id) 
        else 
            render :accept, submission: @submission
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

end