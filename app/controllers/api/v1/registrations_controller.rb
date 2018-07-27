class Api::V1::RegistrationsController < Devise::RegistrationsController
    before_action :ensure_params_exits, only: :create

    def create 
        user = User.new user_params
        if user.save
                json_response "Signed Up successfuly", true, {user: user}, :ok
            else 
                json_response "Something wrong", false, {}, :unprocessable_enity
        end
    end

    private
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def ensure_params_exits
        return if params[:user].present?
        json_response "Missing Params", false, {}, :bad_request
    end
end