class ProfilesController < ApplicationController
  
  # Prima di mostrare la un profilo o i risultati della ricerca utenti verifichiamo che l'utente sia loggato
  before_filter :authenticate_user!, only: [:index, :show]
  
  def show
    @user = User.find_by_profile_name(params[:id])
    if @user
      @statuses = @user.statuses.all
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end
  
  def index
    @users = User.all
    if params[:search]
      puts params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
      puts @users
      if @users
        render action: :results
      end
    else
      @users = User.all.order('created_at DESC')
    end
  end
    

end
