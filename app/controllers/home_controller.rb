class HomeController < ApplicationController
    def index
        @opportunity = Opportunity.last(8)
    end
end