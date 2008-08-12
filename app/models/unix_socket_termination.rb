########################################################################################################
########################################################################################################
class UnixSocketTermination < ActiveRecord::Base

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_termination   

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### virtual attributes
  attr_accessor :pid

  ######################################################################################################
  #### validation
  validates_inclusion_of    :socket_type,  :allow_nil => true, :in => %w(STREAM DGRAM RAW RDM SEQPACKET CONNECTING UNKNOWN)
  validates_inclusion_of    :state,        :allow_nil => true, :in => %w(LISTENING CONNECTED FREE  CONNECTING DISCONNECTING UNKNOWN)

  ######################################################################################################
  #### restrict attribute access

  ####################################################################################################
  def add_associations(supporter)

    supporter << self

  end

  ######################################################################################################
  def sync_key
    self.i_node
  end

  ######################################################################################################
  #### class methods
  class << self

    ####################################################################################################
    def sync_key(params)
      params[:i_node]
    end

    ####################################################################################################
    def socket_type
      %w(STREAM DGRAM RAW RDM SEQPACKET CONNECTING UNKNOWN)
    end

    ####################################################################################################
    def state
      %w(LISTENING CONNECTED FREE  CONNECTING DISCONNECTING UNKNOWN)
    end

  end  

######################################################################################################
protected

end
