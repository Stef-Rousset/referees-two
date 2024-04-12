class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home ressources]

  def home
  end

  def ressources
  end
end
