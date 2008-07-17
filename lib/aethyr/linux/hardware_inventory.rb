############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ##########################################################################################################
    class HardwareInventory

      ######################################################################################################
      #### class methods
      class << self

        ##########################################################################################################
        def build_database
          self.system
          self.memory
          self.cpu
          self.nic
        end
    
      ######################################################################################################
      end  

    ######################################################################################################
    protected

      ######################################################################################################
      #### class methods
      class << self

        ##########################################################################################################
        def memory
          Memory.destroy_all
          attrs = /MemTotal:\s*(\d+)\s(\w+)/.match(`cat /proc/meminfo`)
          Memory.new(:name => 'Memory', :installed => attrs[1], :units => attrs[2]).add_associations(self.find_system)
        end
  
        ##########################################################################################################
        def cpu
          Cpu.destroy_all
          `cat /proc/cpuinfo`
        end
  
        ##########################################################################################################
        def system
          System.destroy_all
          System.new(:name => `hostname`, :os => `uname -a`).save        
        end
  
        ##########################################################################################################
        def nic
          
        end

        ##########################################################################################################
        def find_system
          System.find(:first)
        end

      ######################################################################################################
      end  
      
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end
