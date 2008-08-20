########################################################################################################
########################################################################################################
class NetworkInterfaceTermination < ActiveRecord::Base

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_termination   

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### virtual attributes
  attr_accessor :hw_address

  ######################################################################################################
  #### validation

  ####################################################################################################
  def add_associations(supporter)
    if self.hw_address.eql?('Loopback')
      supporter << self
    else
      nic = supporter.find_supported_by_model(Nic, :first, :conditions => "nics.hw_address = '#{self.hw_address.downcase}'")
      nic << self unless nic.nil?
    end        
  end

  ######################################################################################################
  #### class methods
  class << self
    
    ####################################################################################################
    def synchronize_associations(supporter)
      Nic.synchronize(Aethyr::Linux::Interface::Nic, supporter)
    end
    
  end  

######################################################################################################
protected

end
