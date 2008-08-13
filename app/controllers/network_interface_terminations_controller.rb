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
  before_filter :network_interface_termination, :only => [:edit]
  before_filter :add_page_to_click_path, :only => [:edit]
  before_filter :set_root_page_of_click_path, :only => [:network_interface_terminations_summary]

  ######################################################################################################
  def index    
    initialize_system_users_list(:column => 'name', :sort => 'sort-up', :force => true)
  end
  
########################################################################################################
protected
    
  ######################################################################################################
  def find_nic
    @nic = Nic.find_by_model(params[:nic_id], :readonly => false)
    self.to_system_index_on_error(@nic)
  end
        
end
