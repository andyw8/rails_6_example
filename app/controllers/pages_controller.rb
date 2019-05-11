class PagesController < ApplicationController
  def welcome
    render plain: "hello world"
  end
end
