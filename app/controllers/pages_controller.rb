class PagesController < ApplicationController
  def bungard
    http_basic_authenticate_or_request_with name: "josh", password: "jbfilms"

    @films = Film.all
  end
end
