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

  ######################################################################################################
  #### connection relations
  connection_ingress

  ######################################################################################################
  #### validation
  validates_presence_of  :uid
  validates_presence_of  :default_gid
  validates_presence_of  :home_directory
  validates_presence_of  :login_shell

  ####################################################################################################
  def add_associations(supporter)

    #### supporter relation
    supporter << self

    #### termination and connection support relations
    xc = AlnConnection.new(:name => self.name, :termination_type => 'SystemUserTermination')
    term = SystemUserTermination.new(:name => self.name, :directionality => 'ingress')
    self << [term, xc]
    term.reload

    #### connection relations
    xc << term

  end

  ######################################################################################################
  #### class methods
  class << self
  end  

######################################################################################################
protected

end
