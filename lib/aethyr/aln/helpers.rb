###########################################################################################################
###########################################################################################################
module Aethyr

  ##########################################################################################################
  module Aln
  
    ########################################################################################################
    module Helpers
    
      ######################################################################################################
      def list_supported_models(root, model_class, options = {})
        models = root.find_supported_by_model(model_class, :all)
        model_id = "#{model_class.name.underscore}_id".to_sym
        list_items = ''
        models.each do |m| 
          instance_options = options
          instance_options[:url].update(model_id => m.send(model_id))
          list_items += content_tag :li do
            link_to_remote_with_load_notifier m.name, instance_options                
          end
        end        
        content_tag :ul, list_items
      end

      ######################################################################################################
      def no_association
        content_tag :div, :class => "no-association" do
         'no association'
        end
      end

      ######################################################################################################
      def link_to_associated_model(model, options ={})
        unless model.nil?
          controller = model.class.name.tableize
          model_id = "#{controller.singularize}_id".to_sym 
          options.update(:url => {:controller => controller, :action => 'edit', model_id => model.send(model_id)})
          link_to_remote_with_load_notifier(model.name, options)
        else
          no_association 
        end
      end

    ########################################################################################################
    end

  ##########################################################################################################
  end
      
############################################################################################################
end