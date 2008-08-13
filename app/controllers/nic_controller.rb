########################################################################################################
########################################################################################################
class NicController < ApplicationController

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::MonomodelControllerHelper

  ######################################################################################################
  #### default layout
  layout 'agent'

  ######################################################################################################
  #### filters
  before_filter :find_nic, :only => [:show]

########################################################################################################
protected
    
  ######################################################################################################
  def find_network_interface_terminations
    self.initialize_sortable_table_session(:session_key => :network_interface_terminations_sortable_table, :column => 'name', :sort => 'sort-up', :force => false)
    @network_interface_terminations = NetworkInterfaceTerminationsController.paginate_in_support_hierarchy_by_model(@nic, session)
  end
    
end
