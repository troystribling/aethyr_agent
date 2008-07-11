########################################################################################################
########################################################################################################
class UsersController < ApplicationController

  ######################################################################################################
  #### mixins

  ######################################################################################################
  #### default layout
  layout 'agent'

  ######################################################################################################
  #### filters

  ######################################################################################################
  def index
  end

  ######################################################################################################
  def users_summary
    initialize_users_list(:column => 'name', :sort => 'sort-up', :force => false)
    respond_to do |format|
      format.html {redirect_to(users_path)}
      format.js do
        render :update do |page|
          page['agent-display'].replace_html :partial => 'users_summary'
          page['agent-navigation'].replace_html :partial => 'users/navigation'
          page['display-click-path-wrapper'].hide
          page << "SearchInputMgr.loadSearchInput('/users/users_search');"
        end
      end
    end
  end

########################################################################################################
protected
    
end
