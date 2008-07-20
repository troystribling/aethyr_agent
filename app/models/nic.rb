########################################################################################################
########################################################################################################
class Nic < ActiveRecord::Base

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### validation
  validates_presence_of  :name,           :if => :name_required?
  validates_presence_of  :mac_address,    :if => :mac_address_required?
  validates_presence_of  :ip_address,     :if => :ip_address_required?
  validates_presence_of  :physical_id,    :if => :physical_id_required?

  ####################################################################################################
  def add_associations(supporter)

    #### supporter relation
    supporter << self
    
  end

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

  ####################################################################################################
  def mac_address_required?
    self.name.blank?
  end

  ####################################################################################################
  def ip_address_required?
    self.ip_address.blank?
  end

  ####################################################################################################
  def physical_id_required?
    self.physical_id.blank?
  end

end
