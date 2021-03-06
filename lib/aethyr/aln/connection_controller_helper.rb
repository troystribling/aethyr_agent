###########################################################################################################
#### Aethyr mixin for synchronizing aws models
###########################################################################################################
module Aethyr

    ########################################################################################################
    #### Aln
    ########################################################################################################
    module Aln
  
      ########################################################################################################
      #### methods added to controllers
      ########################################################################################################
      module ConnectionControllerHelper
  
        ######################################################################################################
        def self.included(base) 
          base.send(:include, InstanceMethods) 
          base.extend(ClassMethods)
        end

        ########################################################################################################
        #### instance methods
        ########################################################################################################
        module InstanceMethods

        ########################################################################################################
        end  #### instance methods
        ########################################################################################################
           
        ########################################################################################################
        #### class methods
        ########################################################################################################
        module ClassMethods

          ######################################################################################################
          def has_egress_connections(args = {})
          
            args.assert_valid_keys(:from_model)
            
            connecteded_models = args[:from_model].to_s.pluralize         
            model = /(\S+)Controller/.match(self.name).to_a.last.singularize.underscore
      
            class_eval <<-do_eval

              def find_connected_#{connecteded_models}
                @#{connecteded_models} = @#{model}.#{connecteded_models}
              end
                
            do_eval
                   
          end

          ######################################################################################################
          def has_ingress_connections(args = {})
          
            args.assert_valid_keys(:to_model)
            
            connecteded_models = args[:to_model].to_s.pluralize         
            model = /(\S+)Controller/.match(self.name).to_a.last.singularize.underscore
      
            class_eval <<-do_eval

              def find_connected_#{connecteded_models}
                @#{connecteded_models} = @#{model}.#{connecteded_models}
              end
                
            do_eval
                   
          end

        ########################################################################################################
        end  #### class methods
        ########################################################################################################
                             
      ########################################################################################################
      end #### ControllerHelper
      ########################################################################################################

  ##########################################################################################################
  end #### Aws
  ########################################################################################################

############################################################################################################
end #### Aethyr
############################################################################################################
    