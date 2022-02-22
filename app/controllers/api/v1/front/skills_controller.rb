class Api::V1::Front::SkillsController < ApplicationController
  def index
    @skills = Skill.all
    render json: @skills, status: :ok
  end

  def skills_by_user
    @skills = Skill.by_user(params[:user_id])
    render json: @skills, status: :ok
  end
end
