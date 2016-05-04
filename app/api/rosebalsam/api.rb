module Rosebalsam
  class API < Grape::API
    version "v1", using: :path
    content_type :json, "application/json;charset=UTF-8"
    format :json
    formatter :json, Grape::Formatter::Rabl

    helpers do
      def token_from_request
        request.headers['Authorization'][/Token ([0-9a-f]+)/]
        $1
      end

      def current_user
        token = Token.find_by(token: token_from_request)
        @current_user ||= token.try(:user)
      end

      def authenticate!
        error!("401 Unauthorized", 401) unless current_user
      end
    end

    get "/me", :rabl => "users/show" do
      authenticate!
      @user = @current_user
    end
  end
end
