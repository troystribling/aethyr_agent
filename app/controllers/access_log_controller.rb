########################################################################################################
########################################################################################################
class AccessLogsController < ApplicationController

  ######################################################################################################
  #### default layout
  layout 'single_column'

  ######################################################################################################
  #### declare sortable tables
  responds_to_sortable_table :model => :access_log, :search => true, :paginate => 17

  ######################################################################################################
  #### filters
  before_filter :find_access_log, :only => [:show]
  before_filter :admin_required, :only => [:show, :index, :access_logs_summary]
  before_filter :add_page_to_click_path, :only => [:show]
  before_filter :set_root_page_of_click_path, :only => [:access_logs_summary]

  ######################################################################################################
  def index
    initialize_access_logs_list(:column => 'created_at', :sort => 'sort-up', :force => true)
    respond_to do |format|
      format.html    
    end
  end

  ######################################################################################################
  def show
    respond_to do |format|
      format.html {redirect_to(access_logs_path)}
      format.js do
        render :update do |page|
          page['display-click-path-wrapper'].show
          page['display-click-path'].replace_html :partial => 'common/click_path'
          page['administration-display'].replace_html :partial => 'common/display_list', :object => @access_log
        end
      end
    end
  end

  ######################################################################################################
  def access_log_summary
    initialize_access_logs_list(:column => 'created_at', :sort => 'sort-up', :force => false)
    respond_to do |format|
      format.js do
        render :update do |page|
          page['agent-display'].replace_html :partial => 'access_logs_summary'
          page['agent-navigation'].replace_html :partial => 'users/navigation'
          page['display-click-path-wrapper'].hide
          page << "SearchInputMgr.loadSearchInput('/access_logs/access_logs_search');"
        end
      end
    end
  end

protected

  ######################################################################################################
  def find_access_log
    access_log_id = params[:access_log_id] || params[:id]
    @access_log = AccessLog.find_by_model(access_log_id, :readonly => false)
    if @access_log.nil?
      respond_to do |format|
        format.html {redirect_to(access_logs_path)}
        format.js do
          render :update do |page|
            page.redirect_to access_logs_path 
          end
        end
      end
    end 
  end

end
