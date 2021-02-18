class HomeController < ApplicationController
    def index
        @opportunities = Opportunity.where(is_visible: true).last(8)
    end
end