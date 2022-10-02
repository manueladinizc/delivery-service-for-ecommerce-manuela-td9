class HomeController < ApplicationController
    def index
        @modalities = Modality.all   
    end
end