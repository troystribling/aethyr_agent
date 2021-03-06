########################################################################################################
########################################################################################################
class SystemUsersController < ApplicationController

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::MultimodelControllerHelper
  include Aethyr::Aln::ConnectionControllerHelper

  ######################################################################################################
  #### default layout
  layout 'agent'

  ######################################################################################################
  #### declare sortable tables
  responds_to_sortable_table :model => :system_user, :search => true, :paginate => 17

  ######################################################################################################
  #### declare model connections
  has_ingress_connections :to_model => :system_group

  ######################################################################################################
  #### filters
  before_filter :find_system_user, :only => [:edit]
  before_filter :find_connected_system_groups, :only => [:edit]
  before_filter :add_page_to_click_path, :only => [:edit]
  before_filter :set_root_page_of_click_path, :only => [:system_users_summary]

  ######################################################################################################
  def index    
    initialize_system_users_list(:column => 'name', :sort => 'sort-up', :force => true)
  end
  
########################################################################################################
protected

  ######################################################################################################
  def find_connected_system_groups
    @system_groups = @system_user.system_groups
  end
    
end
