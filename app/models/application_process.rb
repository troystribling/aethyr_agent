########################################################################################################
########################################################################################################
class ApplicationProcess < ActiveRecord::Base

  ######################################################################################################
  #### inheritance relations
  has_ancestor :named => :aln_resource   

  ######################################################################################################
  #### mixins
  include Aethyr::Mixins::Synchronizer::Model
  extend Aethyr::Aln::ConnectedModelHelper  

  ######################################################################################################
  #### virtual attributes
  attr_accessor :user, :ppid

  ######################################################################################################
  #### validation
  validates_presence_of  :name
  validates_presence_of  :pid

  ####################################################################################################
  def add_associations(supporter)

    #### supporter relation
    supporter << self
    
  end

  ######################################################################################################
  def synchronize_models(supporter, local_models, remote_models) 
    model_sync_key = self.sync_key(params)
    model = local_models[model_sync_key]
    remote_models.each{|params| synchronize_model(model, params)}
    remote_models.each{|params| synchronize_model_associations(supporter, model)}
  end

  ######################################################################################################
  def synchronize_model(model, params) 
    if model.nil?
      model = self.new(params)
      model.save
      model.synched = false
    else 
      model.reload
      model.attributes = params
      model.synched = true
      model.save
    end
  end

  ######################################################################################################
  def synchronize_model_associations(supporter, model) 
    unless model.synched
      model.reload
      model.add_associations(supporter)
      supporter.reload unless supporter.nil?
    end
  end

  ######################################################################################################
  #### class methods
  class << self
    
    ####################################################################################################
    def sync_key(params)
p params      
      params[:name] = params[:pid]
      params[:name]
    end
    
  end  

######################################################################################################
protected

  ####################################################################################################
  def name_required?
    self.name.blank?
  end

end
