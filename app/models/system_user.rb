########################################################################################################
########################################################################################################
class SystemUser < ActiveRecord::Base

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### virtual attributes
  attr_accessor :default_gid

  ######################################################################################################
  #### validation
  validates_presence_of  :uid
  validates_presence_of  :default_gid
  validates_presence_of  :home_directory
  validates_presence_of  :login_shell

  ####################################################################################################
  def add_associations

    #### supporter relation
    supporter = System.find_by_model(:first)
    supporter << self
    
  end

  ######################################################################################################
  #### class methods
  class << self
  end  

######################################################################################################
protected

end
