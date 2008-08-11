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
  #### validation
  validates_presence_of  :gid

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
