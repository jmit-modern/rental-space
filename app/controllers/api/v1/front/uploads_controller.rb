class Api::V1::Front::UploadsController < ApplicationController
  before_action :authorize_request, except: %i[]

  def create
    # Make an object in your bucket for your upload
    obj = AwsService::upload(params[:file]) if params[:file].present?

    render json: { url: obj.public_url, name: obj.key }, status: :ok
  end

  def delete
    begin
      key = params[:url].split("amazonaws.com/")[1]
      if key.present?
        S3_BUCKET.object(key).delete
        render json: { message: "Succeed to delete image." }, status: :ok
      else
        render json: { message: "No S3 image." }, status: :ok
      end
    rescue => e
      logger.info e
      return render json: { message: "Failed to delete image." }, status: :unprocessable_entity
    end
  end
end
