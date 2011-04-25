class AuthenticationsController < ApplicationController
  # GET /authentications
  # GET /authentications.xml
  def index
  @authentications = current_user.authentications if current_user

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @authentications }
    end
  end

  # GET /authentications/new
  # GET /authentications/new.xml
  def new
    @authentication = Authentication.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @authentication }
    end
  end

  # POST /authentications
  # POST /authentications.xml
  def create
  #    render :text => request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => auth['provider'], :uid => auth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      if auth["provider"] == "facebook"
       user.email = auth["user_info"]["email"]
      end
      user.apply_omniauth(auth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, authentication.user)
      else
        session[:auth] = auth.except('extra')
        redirect_to new_user_registration_url   
      end
    end
  end


  # DELETE /authentications/1
  # DELETE /authentications/1.xml
  def destroy
  @authentication = current_user.authentications.find(params[:id])
  @authentication.destroy
  flash[:notice] = "Successfully destroyed authentication."
  redirect_to authentications_url
  end
end
