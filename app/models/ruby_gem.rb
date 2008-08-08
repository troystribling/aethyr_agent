########################################################################################################
########################################################################################################
class RubyGem < ActiveRecord::Base

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### validation

  ######################################################################################################
  #### serialized
  serialize :versions

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