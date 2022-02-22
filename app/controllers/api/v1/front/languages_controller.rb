class Api::V1::Front::LanguagesController < ApplicationController
  def index
    @languages = Language.all
    render json: @languages, status: :ok
  end
end
