########################################################################################################
########################################################################################################
class System < ActiveRecord::Base

  ######################################################################################################
  #### need to specify table name
  set_table_name 'system'

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### validation
  validates_presence_of  :os

  ####################################################################################################
  def add_associations(supporter = nil)
    self.save
  end

  ######################################################################################################
  #### class methods
  class << self
  end  

######################################################################################################
protected

end
