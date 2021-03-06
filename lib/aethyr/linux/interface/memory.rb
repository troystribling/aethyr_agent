############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class Memory
  
        ######################################################################################################
        #### class methods
        class << self
  
          ########################################################################################################
          def find(type = :all, options = {})
            if type.eql?(:first)
            else
              self.find_all
            end
          end

        ######################################################################################################
        protected
        
          ##########################################################################################################
          def find_all
            attrs = /MemTotal:\s*(\d+)\s(\w+)/.match(`cat /proc/meminfo`)
            [{:name => 'Memory', :total => attrs[1], :total_units => attrs[2]}]
          end
    
        ######################################################################################################
        end  
        
      ##########################################################################################################
      end
  
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end
