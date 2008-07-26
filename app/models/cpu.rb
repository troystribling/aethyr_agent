########################################################################################################
########################################################################################################
class Cpu < ActiveRecord::Base

  ######################################################################################################
  #### need to specify table name
  set_table_name 'cpu'

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### validation
  validates_presence_of  :count
  validates_presence_of  :frequency
  validates_presence_of  :frequency_units
  validates_presence_of  :model
  validates_presence_of  :vendor

  ####################################################################################################
  def add_associations

    #### supporter relation
    supporter = System.find_by_model(:first)
    supporter << self

    #### termination and connection support relations
    xc = AlnConnection.new(:name => self.name, :termination_type => 'CpuTermination')
    term = CpuTermination.new(:name => self.name, :directionality => 'ingress')
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
