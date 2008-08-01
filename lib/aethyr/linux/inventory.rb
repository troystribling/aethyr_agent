############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ##########################################################################################################
    class Inventory
    
      ######################################################################################################
      #### class methods
      class << self

        ########################################################################################################
        def synchronize
          System.synchronize(Aethyr::Linux::Interface::System)
          sys = System.find_by_model(:first)
#          Memory.synchronize(Aethyr::Linux::Interface::Memory, sys)
#          Cpu.synchronize(Aethyr::Linux::Interface::Cpu, sys)
#          Nic.synchronize(Aethyr::Linux::Interface::Nics, sys)
#          SystemUser.synchronize(Aethyr::Linux::Interface::SystemUsers, sys)
#          SystemGroup.synchronize(Aethyr::Linux::Interface::SystemGroups, sys)
#          ApplicationProcess.synchronize(Aethyr::Linux::Interface::ApplicationProcesses, sys)
#          ApplicationThread.synchronize(Aethyr::Linux::Interface::ApplicationThreads, sys)
#          Device.synchronize(Aethyr::Linux::Interface::Devices, sys)
#          UnixSocketTermination.synchronize(Aethyr::Linux::Interface::UnixSockets, sys)
#          NetworkSocketTermination.synchronize(Aethyr::Linux::Interface::NetworkSockets, sys)
          NetworkInterfaceTermination.synchronize(Aethyr::Linux::Interface::NetworkInterfaces, sys)
        end
  
      ######################################################################################################
      end  
      
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end
