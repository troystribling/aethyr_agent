########################################################################################################
########################################################################################################
class Cpu < ActiveRecord::Base

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### validation

  ######################################################################################################
  #### class methods
  class << self
  end  

######################################################################################################
protected

end