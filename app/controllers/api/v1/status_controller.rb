module Api
  module V1
    class StatusController < ApplicationController
      skip_before_action :authenticate_user!
      before_action :authenticate_api_user

      def update
        # Use current_user if authenticated, otherwise find by email
        user = current_user || User.find_by(email: params[:email])

        unless user
          render json: { error: "User not found" }, status: :not_found
          return
        end

        # Only allow users to update their own status unless they're admin
        unless current_user == user || current_user&.admin?
          render json: { error: "Unauthorized" }, status: :unauthorized
          return
        end

        status = Status.find_by(id: params[:status_id])

        unless status
          render json: { error: "Status not found" }, status: :not_found
          return
        end

        note = params[:note]

        user.update_status!(status, note: note)

        # Broadcast update via ActionCable
        ActionCable.server.broadcast("presence", {
          type: "status_update",
          user: {
            id: user.id,
            name: user.name,
            status: {
              id: status.id,
              label: status.label,
              color_code: status.color_code,
              icon: status.icon
            },
            note: note
          }
        })

        render json: {
          success: true,
          user: {
            id: user.id,
            name: user.name,
            status: {
              id: status.id,
              label: status.label,
              color_code: status.color_code,
              icon: status.icon
            },
            note: note
          }
        }
      end

      private

      def authenticate_api_user
        # Allow authenticated users or users providing email
        # In production, consider implementing API tokens
        unless user_signed_in? || params[:email].present?
          render json: { error: "Authentication required" }, status: :unauthorized
          return false
        end
        true
      end
    end
  end
end
