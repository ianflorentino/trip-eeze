class PagesController < ApplicationController
  def front
    @homepage = true;
    @user = User.new;
  end
end
