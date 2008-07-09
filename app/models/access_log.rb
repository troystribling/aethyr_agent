require 'resolv' 
 
########################################################################################################
########################################################################################################
class AccessLog < ActiveRecord::Base

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :log   

  ######################################################################################################
  #### serialized attributes
  serialize :parameters
  
  ######################################################################################################
  #### valdators
  validates_presence_of :action
  validates_presence_of :controller
  validates_presence_of :ip_address
  validates_presence_of :uri
  validates_presence_of :session
  validates_presence_of :session_start
  validates_presence_of :parameters

  ######################################################################################################
  #### callback chains
  before_save :resolve_dns
 
  ######################################################################################################
  #### class methods
  class << self
  
    ####################################################################################################
    def to_log(resource, request)
      if resource.eql?(:false)
        resource_name, resource_id = 'UNKNOWN', nil
      else 
        resource_name, resource_id = resource.name, resource.resource_with_log_id
      end
      parameters = request.parameters.to_yaml.sub(/password: ".*?"/, 'password: "*"')
      parameters.sub!(/password_confirmation: ".*?"/, 'password_confirmation: "*"')
      self.new(:name => resource_name, :resource_with_log_id => resource_id, :action => request.path_parameters[:action],   
               :controller => request.path_parameters[:controller], :ip_address => request.remote_ip, :uri => request.request_uri, 
               :session => request.session.session_id, :session_start => request.session.model.created_at,
               :http_user_agent => request.env['HTTP_USER_AGENT'], :http_referer => request.env['HTTP_REFERER'],
               :parameters => parameters).save
    end
    
    ####################################################################################################
    def find_by_session(request, limit = nil)
      options = {:conditions => "access_logs.session = '#{request.session.session_id}'", :order => "logs.created_at DESC"}
      options.update(:limit => limit) unless limit.nil?
      self.find_by_model(:all, options)
    end

    ####################################################################################################
    def this_request(request)
      options = {:conditions => "access_logs.session = '#{request.session.session_id}'", :order => "logs.created_at DESC"}
      cur_req = self.find_by_model(:first, options)
      {:controller => cur_req.controller, :action => cur_req.action}
    end
    
    ####################################################################################################
    def previous_request(request)
      this_request = {:controller => request.path_parameters[:controller], :action => request.path_parameters[:action]} 
      previous_request = this_request
      count = 2     
      while  previous_request == this_request
        access_record = self.find_by_session(request, count).last
        previous_request = access_record.parameters
        previous_request.delete(:authenticity_token)
        count += 1
        previous_request = {:controller => 'services', :action =>'show_dashboard'} \
          if count > 10 or previous_request == {:controller=>"services", :action=>"index"} 
      end
      previous_request
    end
        
  end  
 
######################################################################################################
protected

  ######################################################################################################
  def resolve_dns
    begin
      self.dns_name = Resolv.getname(self.ip_address)
    rescue Resolv::ResolvError
      self.dns_name = 'UNKNOWN'
    end
  end
  
end
