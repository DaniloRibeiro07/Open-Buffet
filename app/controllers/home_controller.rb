class HomeController < ApplicationController
  def index
      @buffet_records = BuffetRegistration.all.active
  end
end