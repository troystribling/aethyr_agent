########################################################################################################
########################################################################################################
class DiskPartition < ActiveRecord::Base

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### validation

  ####################################################################################################
  def add_associations

    sys = System.find_by_model(:first)
    sys << self
    
  end

  ######################################################################################################
  #### class methods
  class << self
  end  

######################################################################################################
protected

end
