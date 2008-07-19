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

  ####################################################################################################
  def add_associations(supporter)

    #### supporter relation
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
