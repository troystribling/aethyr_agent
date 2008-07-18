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
          AlnConnection.destroy_all
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
          MemoryTermination.destroy_all
          attrs = /MemTotal:\s*(\d+)\s(\w+)/.match(`cat /proc/meminfo`)
          Memory.new(:name => 'Memory', :machine => attrs[1], :units => attrs[2]).add_associations(self.find_system)
        end
  
        ##########################################################################################################
        def cpu
          Cpu.destroy_all
          rows = `cat /proc/cpuinfo`.split("\n")
          count = rows.length/20 + 1
          Cpu.new(:name => 'CPU', :count => count, :frequency => freq, :frequency_units => freq_units,  :model =>  model, :vendor => vendor).add_associations(self.find_system)
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
