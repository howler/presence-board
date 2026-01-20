module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user!
      before_action :authenticate_api_user

      def index
        users = User.includes(:department, :current_status).order(:name)

        if params[:department_id].present?
          users = users.where(department_id: params[:department_id])
        end

        if params[:search].present?
          users = users.where("name ILIKE ? OR email ILIKE ?",
                              "%#{params[:search]}%",
                              "%#{params[:search]}%")
        end

        render json: users.map { |user|
          {
            id: user.id,
            name: user.name,
            email: user.email,
            department: user.department&.name,
            avatar_url: user.avatar_url,
            status: user.current_status ? {
              id: user.current_status.id,
              label: user.current_status.label,
              color_code: user.current_status.color_code,
              icon: user.current_status.icon
            } : nil,
            note: user.current_note,
            last_updated: user.status_logs.last&.created_at
          }
        }
      end

      private

      def authenticate_api_user
        # For MVP, allow unauthenticated access to API
        # In production, implement proper API authentication
        true
      end
    end
  end
end
