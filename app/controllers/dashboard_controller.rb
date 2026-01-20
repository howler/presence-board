class DashboardController < ApplicationController
  skip_before_action :authenticate_user!, only: [:kiosk]

  def index
    @users = User.includes(:department, :current_status).order(:name)

    if params[:search].present?
      @users = @users.where("name ILIKE ? OR email ILIKE ?",
                           "%#{params[:search]}%",
                           "%#{params[:search]}%")
    end

    if params[:department_id].present?
      @users = @users.where(department_id: params[:department_id])
    end

    @statuses = Status.order(:label)
    @departments = Department.order(:name)
  end

  def kiosk
    @users = User.includes(:department, :current_status).order(:name)
    @statuses = Status.order(:label)
    render layout: "kiosk"
  end
end
