########################################################################################################
########################################################################################################
class FileTermination < ActiveRecord::Base

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_termination   

  ######################################################################################################
  #### virtual attributes
  attr_accessor :pid, :device

  ######################################################################################################
  #### validation

  ######################################################################################################
  #### restrict attribute access

  ######################################################################################################
  def sync_key
    "#{self.pid}-#{self.fd}-#{self.i_node}"
  end

  ####################################################################################################
  def add_associations(supporter)

    supporter << self

  end

  ######################################################################################################
  #### class methods
  class << self
    
    ####################################################################################################
    def sync_key(params)
      "#{params[:pid]}-#{params[:fd]}-#{params[:i_node]}"
    end
    
  end  

######################################################################################################
protected

end
