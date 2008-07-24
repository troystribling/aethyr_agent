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
  #### class methods
  class << self
    
    ####################################################################################################
    def sync_key(params)
      params[:name] = params[:pid]
      params[:name]
    end

    ######################################################################################################
    def synchronize_models(supporter, local_models, remote_models)
      remote_models.each do |params| 
        synchronize_model(local_models[self.sync_key(params)], params)
      end
      remote_models.each do |params| 
        synchronize_model_associations(supporter, local_models[self.sync_key(params)])
      end
    end
  
    ######################################################################################################
    def synchronize_model(model, params) 
      if model.nil?
p params      
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

  end  

######################################################################################################
protected

  ####################################################################################################
  def name_required?
    self.name.blank?
  end

end
