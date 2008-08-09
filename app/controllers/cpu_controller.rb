########################################################################################################
########################################################################################################
class CpuController < ApplicationController

  ######################################################################################################
  #### mixins
  include Aethyr::Aws::Mixins::Synchronizer::Controller

  ######################################################################################################
  #### default layout
  layout 'agent'

  ######################################################################################################
  #### filters
  before_filter :find_cpu, :only => [:show]

  ######################################################################################################
  def show
    respond_to do |format|
      format.js do
        render :update do |page|
          page['agent-display'].replace_html :partial => 'show'
        end
      end
    end
  end

########################################################################################################
protected
    
  ######################################################################################################
  def find_cpu
    @cpu = Cpu.find_by_model(:first, :readonly => false)
    if @cpu.nil?
      respond_to do |format|
        format.html {redirect_to(system_index_path)}
        format.js do
          render :update do |page|
            page.redirect_to system_index_path 
          end
        end
      end
    end 
  end
    
end
