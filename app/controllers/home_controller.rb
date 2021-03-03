class HomeController < ApplicationController
    def index
        @opportunities = Opportunity.where(
            'is_visible == ? AND expiration_date > ?', 
            true,
            "#{0.day.from_now}"
        ).last(8)
    end

    def search 
        @layout = params[:search_option]
        if @layout == 'opportunity'
            @data = Opportunity.where(
                'title like ?',
                "%#{params[:q]}%"
            )
        elsif @layout == 'company'
            @data = Company.where(
                'name like ?',
                "%#{params[:q]}%"
            )
        end
    end
    
end