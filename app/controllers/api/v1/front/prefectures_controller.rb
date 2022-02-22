class Api::V1::Front::PrefecturesController < ApplicationController

  # GET /api/v1/front/prefecturesspaces or /api/v1/front/prefectures.json
  def index
    @prefectures = Prefecture.all
    render json: @prefectures, status: :ok
  end
end
