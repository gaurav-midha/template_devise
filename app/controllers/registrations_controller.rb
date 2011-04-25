class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end
 private
   
  def build_resource(*args)
    super
    if session[:auth]
      @user.apply_omniauth(session[:auth])
      @user.valid?
    end
  end 
end
