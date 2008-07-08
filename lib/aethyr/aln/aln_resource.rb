#####################################################################################
class AlnResource < ActiveRecord::Base

  ######################################################################################################
  def paginate_in_support_hierarchy_by_model(model, args={})
    condition = self.find_in_support_hierarchy_by_model_conditions
    if args.include?(:conditions) and not args[:conditions].blank? 
      args[:conditions] << ' AND ' + condition
    else 
      args[:conditions] = condition
    end  
    model.paginate(args)
  end

  ######################################################################################################
  def self.find_root
    root = AlnResource.find_by_name('root')
    if root.nil?
      root = AlnResource.new(:name => 'root')
      root.save
    end
    root
  end

end
