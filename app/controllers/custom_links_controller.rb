class CustomLinksController < ApplicationController

  layout 'admin'
  menu_item :custom_menu
  before_filter :require_admin

  def index
    @custom_links = CustomLink.all
  end

  def new
    @custom_link = CustomLink.new
  end

  def create
    CustomLink.create(custom_link_params)
    add_custom_link(custom_link_params)
    flash[:notice] = l('custom_menu_link.successful_create')
    redirect_to :action => 'index'
  end

  def edit
    @custom_link = CustomLink.find(params[:id])
  end

  def update
    @custom_link = CustomLink.find(params[:id])
    delete_custom_link(@custom_link)
    add_custom_link(custom_link_params)
    puts params[:custom_link]
    if @custom_link.update_attributes custom_link_params
      flash[:notice] = l('custom_menu_link.successful_update')
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @custom_link = CustomLink.find(params[:id])
    delete_custom_link(@custom_link)
    @custom_link.destroy
    flash[:notice] = l('custom_menu_link.successful_delete')
    redirect_to :action => 'index'
  end

  private

  def add_custom_link(custom_link)
    Redmine::MenuManager.map(:top_menu).push custom_link[:name].to_sym, custom_link[:url], {:caption => custom_link[:name] }.merge(first_or_after(custom_link[:after_which])) unless Redmine::MenuManager.map(:top_menu).exists?(custom_link[:name].to_sym)
  end

  def delete_custom_link(custom_link)
    Redmine::MenuManager.map(:top_menu).delete(custom_link.name.to_sym) if Redmine::MenuManager.map(:top_menu).exists?(custom_link.name.to_sym)
  end

  def custom_link_params
    params.require(:custom_link).permit(:name, :url, :after_which)
  end

  def first_or_after(position)
    return {:first => true} if position == "first in list"
    {:after => position.to_sym}
  end
end
