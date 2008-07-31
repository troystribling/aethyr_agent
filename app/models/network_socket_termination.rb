########################################################################################################
########################################################################################################
class NetworkSocketTermination < ActiveRecord::Base

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_termination   

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### virtual attributes
  attr_accessor :pid, :local_address

  ######################################################################################################
  #### validation
  validates_inclusion_of    :protocol,             :allow_nil,  :in => %w(tcp tcp6 udp)
  validates_inclusion_of    :network_socket_state, :allow_nil,  :in => %w(ESTABLISHED SENT RECV WAIT1 WAIT2 WAIT CLOSED CLOSE_WAIT LAST_ACK LISTEN CLOSING UNKNOWN)

  ######################################################################################################
  #### restrict attribute access

  ####################################################################################################
  def add_associations
    
    sys = System.find_by_model(:first)
    sys << self
    
  end

  ######################################################################################################
  def sync_key
    self.local_port
  end
    
  ######################################################################################################
  #### class methods
  class << self
    
    ####################################################################################################
    def sync_key(params)
      params[:local_port]
    end

    ####################################################################################################
    def protocol
      %w(tcp tcp6 udp)
    end

    ####################################################################################################
    def unix_socket_state
      %w(ESTABLISHED SENT RECV WAIT1 WAIT2 WAIT CLOSED CLOSE_WAIT LAST_ACK LISTEN CLOSING UNKNOWN)
    end

  end  
    
######################################################################################################
protected

end
