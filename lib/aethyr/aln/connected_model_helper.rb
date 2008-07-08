########################################################################################################
########################################################################################################
module Aethyr

  ######################################################################################################
  module Aln
  
    ####################################################################################################
    # methods added to aln_resource to manage connections with other resources
    ####################################################################################################
    module ConnectedModelHelper

      ##################################################################################################
      def connection_egress (args = {})

        args.assert_valid_keys(:from_model)
        from_model = args[:from_model].to_s

        Egress.add_methods(self, from_model)
        IngressAndEgress.add_methods(self, from_model)
        
      end

      ##################################################################################################
      def connection_ingress (args = {})

        args.assert_valid_keys(:to_model)

        Ingress.add_methods(self, args[:to_model]) unless args[:to_model].nil?
        IngressAndEgress.add_methods(self, self.name.underscore)
        
      end
       
    ######################################################################################################
    end

    #####################################################################################################
    # connection ingress methods
    #####################################################################################################
    module Ingress

      ####################################################################################################
      def self.add_methods(target, to_model)
      
        model = target.name.underscore
        to_model = to_model.to_s
        
          target.class_eval <<-do_eval

            def #{to_model.pluralize}              
              #{to_model}_remote_terminations.collect {|t| t.supporter.to_descendant}
            end

            def #{to_model}_remote_terminations
              unless #{model}_connection.nil?
                #{model}_connection.find_termination_as_type(:all, :conditions => "aln_terminations.directionality = 'egress'")
              else
                []
              end
            end

            def #{to_model}_not_connected?
              #{to_model}_remote_terminations.empty?
            end

          do_eval
      
      end

    ######################################################################################################
    end

    ######################################################################################################
    # connection egress methods
    ######################################################################################################
    module Egress

      ####################################################################################################
      def self.add_methods(target, from_model=nil)

        target.class_eval <<-do_eval

          def #{from_model}
            #{from_model}_remote_termination.supporter.to_descendant unless #{from_model}_remote_termination.nil?
          end

          def #{from_model}_remote_termination
            #{from_model}_connection.find_termination_as_type(:first, :conditions => "aln_terminations.directionality = 'ingress'") unless #{from_model}_connection.nil?
          end

        do_eval

      end
        
    ######################################################################################################
    end

    ######################################################################################################
    # methods used by both connection egress and ingress
    ######################################################################################################
    module IngressAndEgress

      ####################################################################################################
      def self.add_methods(target, model)

        target.class_eval <<-do_eval

          def #{model}_termination
            self.find_supported_by_model(#{model.classify}Termination, :first)
          end

          def #{model}_connection
            #{model}_termination.aln_connection unless #{model}_termination.nil?
          end
      
        do_eval

      end
    
    ####################################################################################################
    end
     
  ######################################################################################################
  end
                 
  ######################################################################################################
end
