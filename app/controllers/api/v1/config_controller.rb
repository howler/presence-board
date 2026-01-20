module Api
  module V1
    class ConfigController < ApplicationController
      skip_before_action :authenticate_user!

      def show
        render json: {
          statuses: Status.order(:label).map { |status|
            {
              id: status.id,
              label: status.label,
              color_code: status.color_code,
              icon: status.icon
            }
          },
          departments: Department.order(:name).map { |dept|
            {
              id: dept.id,
              name: dept.name
            }
          }
        }
      end
    end
  end
end
