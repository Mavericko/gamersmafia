class Admin::ClanesController < ApplicationController
  require_admin_permission :capo

  def index
    @title = 'Clanes'
    @navpath = [['Admin', '/admin'], ['Clanes', '/admin/clanes']]
    @clans = Clan.paginate(:page => params[:page], :per_page => 50, :conditions => 'deleted is false', :order => 'created_on DESC')
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  #verify :method => :post, :only => [ :destroy, :create, :update ],
  #:redirect_to => { :action => :index }

  def edit
    @clan = Clan.find(params[:id])
    @navpath = [['Admin', '/admin'], ['Clanes', '/admin/clanes'], [@clan.name, "/admin/clanes/edit/#{@clan.id}"]]
    @title = "Editar #{@clan.name}"
  end

  def update
    @clan = Clan.find(params[:id])
    if @clan.update_attributes(params[:clan])
      flash[:notice] = 'Clan actualizado correctamente.'
      redirect_to :action => 'edit', :id => @clan
    else
      render :action => 'edit'
    end
  end

  def destroy
    c = Clan.find(params[:id])
    c.mark_as_deleted
    flash[:notice] = "Clan #{c.name} borrado correctamente."
    redirect_to "/admin/clanes?page=#{params[:page]}"
  end

  def add_user_to_clans_group
    cg = ClansGroup.find(params[:clans_group_id])
    cg.users<< User.find_by_login!(params[:login])
    redirect_to "/admin/clanes/edit/#{cg.clan.id}"
  end

  def remove_user_from_clans_group
    cg = ClansGroup.find(params[:clans_group_id])
    cg.users.delete(User.find(params[:user_id]))
    render :nothing => true
  end
end
