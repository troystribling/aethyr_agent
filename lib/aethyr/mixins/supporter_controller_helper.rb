###########################################################################################################
#### Aethyr mixin for synchronizing aws models
###########################################################################################################
module Aethyr

    ########################################################################################################
    #### Mixins
    ########################################################################################################
    module Mixins
  
      ########################################################################################################
      #### methods added to controllers
      ########################################################################################################
      module SupporterControllerHelper
  
        ######################################################################################################
        def self.included(base) 
          base.send(:include, Aethyr::Mixins::SupporterControllerHelper::InstanceMethods) 
          extend(Aethyr::Mixins::SupporterControllerHelper::ClassMethods)
        end

        ########################################################################################################
        #### instance methods
        ########################################################################################################
        module InstanceMethods

          ########################################################################################################
          def initialize_sortable_table_session(args)
            args.assert_valid_keys(:session_key, :column, :sort, :force)
            args[:force].nil? ? force = true : force = args[:force]
            table_is_new = false
            unless session[args[:session_key]]
              session[args[:session_key]] = {}
              table_is_new = true
            end 
            if table_is_new or force
              session[args[:session_key]][:column] = args[:column]
              session[args[:session_key]][:sort] = args[:sort]
              session[args[:session_key]][:page] = 1
            end
          end

        end
           
        ########################################################################################################
        #### class methods
        ########################################################################################################
        module ClassMethods

          ######################################################################################################
          def has_supported(args = {})
          
            args.assert_valid_keys(:model, :sort_column)
            supported_models = args[:model].to_s.pluralize         
            column = args[:column] || 'name'
            model = /(\S+)Controller/.match(self.name).to_a.last
      
            class_eval <<-do_eval

              def find_#{supported_models}
                self.initialize_sortable_table_session(:session_key => :#{supported_models}_sortable_table, :column => '#{column}', :sort => 'sort-up', :force => false)
                @#{supported_models} = #{supported_models.camelize}Controller.paginate_in_support_hierarchy_by_model(@#{model}, session)
              end
                
            do_eval
                   
          end

        end
                             
      ########################################################################################################
      end #### ControllerHelper
      ########################################################################################################

  ##########################################################################################################
  end #### Aws
  ########################################################################################################

############################################################################################################
end #### Aethyr
############################################################################################################
    