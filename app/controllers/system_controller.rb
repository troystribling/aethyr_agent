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
  before_filter :find_system, :only => [:index, :show_dashboard]
  before_filter :find_memory, :only => [:index, :show_dashboard]
  before_filter :find_cpu, :only => [:index, :show_dashboard]


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
      format.html {redirect_to(system_index_path)}
      format.js do
        render :update do |page|
          page.redirect_to system_index_path
        end
      end
    end
  end

########################################################################################################
protected
    
  def find_system
    @system = System.find_by_model(:first, :readonly => false)
    self.to_system_index_on_error(@system)
  end

  def find_memory
    @memory = Memory.find_by_model(:first, :readonly => false)
    self.to_system_index_on_error(@memory)
  end

  def find_cpu
    @cpu = Cpu.find_by_model(:first, :readonly => false)
    self.to_system_index_on_error(@cpu)
  end

end
