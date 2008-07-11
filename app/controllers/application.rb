########################################################################################################
########################################################################################################
class ApplicationController < ActionController::Base

  ######################################################################################################
  #### mixins
  extend Aethyr::Mixins::SortableTable::Controller
  include Aethyr::Mixins::Error  
  include Aethyr::Mixins::Navigator::Controller

  ######################################################################################################
  #### include all helpers, all the time
  helper :all

  ######################################################################################################
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery  :secret => 'f93dc3b997c4dcba9132a70452ab408c'

  ######################################################################################################
  #### filters applied before all method calls
  before_filter :to_access_log
  before_filter :instantiate_controller_and_action_names

  ######################################################################################################
  #### class methods
  class << self    
  end
  
protected

  ######################################################################################################
  def instantiate_controller_and_action_names
    @current_action = action_name
    @current_controller = controller_name
  end 

  ######################################################################################################
  def to_access_log 
    AccessLog.to_log(request)
  end
  
end
