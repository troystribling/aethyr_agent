########################################################################################################
########################################################################################################
class NetworkInterfaceTerminationsController < ApplicationController

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::MultimodelControllerHelper

  ######################################################################################################
  #### default layout
  layout 'agent'

  ######################################################################################################
  #### declare sortable tables
  responds_to_sortable_table :model => :network_interface_termination, :search => true, :paginate => 5, 
                             :supporter => :find_nic

  ######################################################################################################
  #### filters
  before_filter :find_network_interface_termination, :only => [:edit]
  before_filter :add_page_to_click_path, :only => [:edit]

########################################################################################################
protected
    
  ######################################################################################################
  def find_nic
    @nic = Nic.find_by_model(params[:nic_id], :readonly => false)
    self.to_system_index_on_error(@nic)
  end
        
end
