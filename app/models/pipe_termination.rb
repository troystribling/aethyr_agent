########################################################################################################
########################################################################################################
class PipeTermination < ActiveRecord::Base

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_termination   

  ######################################################################################################
  #### validation

  ######################################################################################################
  #### restrict attribute access

  ####################################################################################################
  def add_associations
    
  end

  ######################################################################################################
  #### class methods
  class << self
  end  

######################################################################################################
protected

end