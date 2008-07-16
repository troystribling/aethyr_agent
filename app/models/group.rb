########################################################################################################
########################################################################################################
class Group < ActiveRecord::Base

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### validation
  validates_presence_of  :name,    :if => :name_required?

  ######################################################################################################
  #### class methods
  class << self
  end  

######################################################################################################
protected

end