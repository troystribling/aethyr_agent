########################################################################################################
########################################################################################################
class SystemGroup < ActiveRecord::Base

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### virtual attributes
  attr_accessor :system_users

  ######################################################################################################
  #### connection relations
  connection_egress :from_model => :system_user

  ######################################################################################################
  #### validation
  validates_presence_of  :gid

  ####################################################################################################
  def add_associations(supporter)

    #### supporter relation
    supporter << self

    #### associated users
    user_models = supporter.find_supported_by_model(SystemUser, :all).select{|m| self.system_users.include?(m.name) or m.default_gid.eql?(self.gid)}
      
    #### user terminations
    user_models.each{|m| self << SystemUserTermination.new(:name => m.name, :directionality => 'egress')}

    #### user connections
    user_models.each {|m| m.system_user_connection << self.system_user_termination_named(m.name)}
    
  end

  ######################################################################################################
  #### class methods
  class << self

    ####################################################################################################
    def synchronize_associations(supporter)
      SystemUser.synchronize(Aethyr::Linux::Interface::SystemUsers, supporter)
    end
    
  end  

######################################################################################################
protected

end
