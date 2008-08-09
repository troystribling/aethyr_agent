########################################################################################################
########################################################################################################
class SystemController < ApplicationController

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
  def show_dashboard
    respond_to do |format|
      format.html {redirect_to(agent_path)}
      format.js do
        render :update do |page|
          page['agent-display'].replace_html :partial => 'dashboard'
          page['display-click-path-wrapper'].hide
        end
      end
    end
  end

  ######################################################################################################
  def synchronize
    Aethyr::Linux::Inventory.synchronize
    respond_to do |format|
      format.html {redirect_to(system_path)}
      format.js do
        render :update do |page|
          page.redirect_to system_path
        end
      end
    end
  end

########################################################################################################
protected
    
end
