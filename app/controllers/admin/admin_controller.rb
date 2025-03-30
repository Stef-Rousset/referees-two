module Admin
  class AdminController < ApplicationController

    def index
      authorize([:admin, :admin]) # for namespace admin policy
    end
  end
end
