########################################################################################################
########################################################################################################
class ApplicationController < ActionController::Base

  ######################################################################################################
  #### mixins
  extend Aethyr::Mixins::SortableTable::Controller::ClassMethods
  include Aethyr::Mixins::SortableTable::Controller::InstanceMethods
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
  
  def to_system_index_on_error(model)
    if model.nil?
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

  def to_500_error(model)
    if model.nil?
      respond_to do |format|
        format.html {redirect_to("/500.html")}
        format.js do
          render :update do |page|
            page.redirect_to("/500.html")
          end
        end
      end
    end
  end
    
end
