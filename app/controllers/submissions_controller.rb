class SubmissionsController < ApplicationController
    before_action :authenticate_user!, only: %i[new create remove destroy]
    before_action :restrict_to_owner!, only: %i[remove destroy]

    def new
        opportunity_id = params[:opportunity_id]
        if opportunity_id.nil?
            redirect_to root_path
        end
        @submission = Submission.new()
        @submission.opportunity = Opportunity.find(params[:opportunity_id])
        @submission.profile = current_user.profile
    end

    def create 
        @submission = Submission.new(allowed_params)
        @submission.opportunity = get_opportunity
        @submission.profile = current_user.profile
        if @submission.save
            redirect_to @submission.opportunity
        else
            render :new, opportunity_id: @submission.opportunity
        end
    end

    def remove 
        @submission = Submission.find(params[:id])
    end

    def destroy
        @submission = Submission.find(params[:id])
        @submission.status = :removed
        @submission.save
        redirect_to root_path
    end

    private
    def allowed_params 
        params.require(:submission).permit(
            :wage_claim,
            :note,
            :presentation,
        )
    end

    def get_opportunity
        opportunity_id = params.require(:submission).permit(:opportunity)
        Opportunity.find(opportunity_id[:opportunity])
    end

    def restrict_to_owner!
        unless Submission.find(params[:id]).profile == current_user.profile
            redirect_to root_path
        end
    end
end