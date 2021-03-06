########################################################################################################
########################################################################################################
class RubyGemsEnvironment < ActiveRecord::Base

  ######################################################################################################
  #### need to specify table name
  set_table_name 'ruby_gems_environment'

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### validation

  ######################################################################################################
  #### serialized
  serialize :platforms
  serialize :gem_paths
  serialize :remote_sources
  serialize :gem_configuration

  ####################################################################################################
  def add_associations(supporter)

    supporter << self

  end

  ######################################################################################################
  #### class methods
  class << self
  end  

######################################################################################################
protected

end
