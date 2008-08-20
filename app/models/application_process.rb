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
  attr_accessor :user, :ppid, :tt

  ######################################################################################################
  #### validation
  validates_presence_of  :pid

  ####################################################################################################
  def add_associations(system)

     if self.ppid.eql?(0)
       system << self
     else
       parent_process = ApplicationProcess.find_by_pid(self.ppid)
       parent_process << self unless parent_process.nil?
     end
   
      user = supporter.find_supported_by_model(SystemUser, :first, :conditions => "aln_resources.name = '#{self.user}'")
      dev = supporter.find_supported_by_model(Device, :first, :conditions => "aln_resources.name = '#{self.tt}'")
   
  end

  ######################################################################################################
  #### class methods
  class << self
    
    ####################################################################################################
    def sync_key(params)
      params[:name] = params[:pid]
      params[:name]
    end

    ####################################################################################################
    def synchronize_associations(supporter)
      SystemUser.synchronize(Aethyr::Linux::Interface::SystemUsers, supporter)
      Devices.synchronize(Aethyr::Linux::Interface::Devices, supporter)
    end
    
    ######################################################################################################
    def synchronize_models(supporter, local_models, remote_models)
      new_models = []
      remote_models.each do |params| 
        synchronize_model(local_models[self.sync_key(params)], params, new_models)
      end
      new_models.each do |model| 
        synchronize_model_associations(supporter, model)
      end
    end
  
    ######################################################################################################
    def synchronize_model(model, params, new_models) 
      if model.nil?        
        model = self.new(params)
        new_models << model
      else 
        model.reload
        model.attributes = params
        model.synched = true
    end
      model.save
    end
  
    ######################################################################################################
    def synchronize_model_associations(supporter, model) 
      model.reload
      model.add_associations
      model.synched = true
      supporter.reload unless supporter.nil?
    end

  end  

######################################################################################################
protected

end
