########################################################################################################
########################################################################################################
class AccessLogsController < ApplicationController

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::MultimodelControllerHelper

  ######################################################################################################
  #### default layout
  layout 'agent'

  ######################################################################################################
  #### declare sortable tables
  responds_to_sortable_table :model => :access_log, :search => true, :paginate => 17

  ######################################################################################################
  #### filters
  before_filter :find_access_log, :only => [:edit]
  before_filter :add_page_to_click_path, :only => [:edit]
  before_filter :set_root_page_of_click_path, :only => [:access_logs_summary]

protected

end
