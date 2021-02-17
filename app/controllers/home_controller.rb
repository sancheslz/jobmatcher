class HomeController < ApplicationController
    def index
        @opportunities = Opportunity.last(8)
    end
end