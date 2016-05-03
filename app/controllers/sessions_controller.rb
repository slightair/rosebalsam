class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.find_by(provider: auth['provider'], uid: auth['uid']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id

    if client_code = params[:client]
      if client = Client.find_by(code: client_code)
        redirect_to client.callback_url_with current_user.token
      else
        render :nothing => true, :status => 404
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
