class HomeController < ApplicationController
    def index
        @opportunities = Opportunity.where('is_visible == ? AND expiration_date > ?', true, "#{0.day.from_now}").last(8)
    end
end