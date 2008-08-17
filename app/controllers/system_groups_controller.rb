########################################################################################################
########################################################################################################
class SystemGroupsController < ApplicationController

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::MultimodelControllerHelper

  ######################################################################################################
  #### default layout
  layout 'agent'

  ######################################################################################################
  #### declare sortable tables
  responds_to_sortable_table :model => :system_group, :search => true, :paginate => 17

  ######################################################################################################
  #### filters
  before_filter :find_system_group, :only => [:edit]
  before_filter :find_connected_system_users, :only => [:edit]
  before_filter :add_page_to_click_path, :only => [:edit]
  before_filter :set_root_page_of_click_path, :only => [:system_groups_summary]

########################################################################################################
protected

  ######################################################################################################
  def find_connected_system_users    
    @system_users = @system_group.system_users
  end
  
end
