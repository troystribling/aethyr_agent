########################################################################################################
########################################################################################################
class System < ActiveRecord::Base

  ######################################################################################################
  #### need to specify table name
  set_table_name 'system'

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

  ####################################################################################################
  def name_required?
    self.name.blank?
  end

end
