########################################################################################################
########################################################################################################
class FileSystemsController < ApplicationController

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

  ######################################################################################################
  def find_aws_storage_bucket
    @aws_storage_bucket = AwsStorageBucket.find_by_model(params[:aws_storage_bucket_id], :readonly => false)
    if @aws_storage_bucket.nil?
      respond_to do |format|
        format.html {redirect_to(services_path)}
        format.js do
          render :update do |page|
            page.redirect_to services_path 
          end
        end
      end
    else
      @aws_storage_bucket
    end 
  end

  ######################################################################################################
  def find_supporting_aws_storage_bucket
    @aws_storage_bucket = @aws_storage_object.find_supporter_by_model(AwsStorageBucket)                
    @remote_aws_storage_bucket = Aethyr::Aws::Interface::StorageBucket.new(@aws_storage_bucket.credential).find(:first, 
      :name => @aws_storage_bucket.name) if @aws_storage_bucket.sync_status.eql?('active')
  end
  
  ######################################################################################################
  def find_aws_storage_objects
    @aws_storage_objects = self.class.paginate_in_support_hierarchy_by_model(@aws_storage_bucket, session)
  end
  

end
