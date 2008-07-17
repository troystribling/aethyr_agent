require 'aethyr/linux/hardware_inventory'

############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ##########################################################################################################
    class Inventory
    
      ######################################################################################################
      #### class methods
      class << self

        ##########################################################################################################
        def build_database
          Aethyr::Linux::HardwareInventory.build_database
        end
    
      ######################################################################################################
      end  

    ######################################################################################################
    protected

      ######################################################################################################
      #### class methods
      class << self
    
      ######################################################################################################
      end  
          
          
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end