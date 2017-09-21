class CheckoutsController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def place_order
  end
end
