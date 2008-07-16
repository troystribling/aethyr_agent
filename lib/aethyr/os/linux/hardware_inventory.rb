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
        System.new(:name => `hostname`, :os => `uname -a`).save        
      end

      ##########################################################################################################
      def storage
        fstab = `cat /etc/fstab`
        part = `cat /proc/partitions`
        
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
