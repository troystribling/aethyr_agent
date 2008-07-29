############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class System
  
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
            [{:name => `hostname`.gsub("\n", ''), :os => `uname -a`.gsub("\n", '')}]
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
