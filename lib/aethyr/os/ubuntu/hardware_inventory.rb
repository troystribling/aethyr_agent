############################################################################################################
module Aethyr

  ############################################################################################################
  module Ubuntu
  
    ##########################################################################################################
    module HardwareInventory
    
      ##########################################################################################################
      def memory
        data = `cat /proc/meminfo`
        
      end

      ##########################################################################################################
      def cpu
        data = `cat /proc/cpuinfo`
        
      end

      ##########################################################################################################
      def system
        
      end

      ##########################################################################################################
      def storage
        
      end

      ##########################################################################################################
      def network
        
      end
      
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end
