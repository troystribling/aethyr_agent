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

          Memory.synchronize(Aethyr::Linux::Interface::Memory, sys)
          Cpu.synchronize(Aethyr::Linux::Interface::Cpu, sys)

          #### Nic, NetworkInterfaceTermination
          NetworkInterfaceTermination.synchronize(Aethyr::Linux::Interface::NetworkInterfaces, sys)
          
          #### SystemGroup, SystemUser
#          SystemUser.synchronize(Aethyr::Linux::Interface::SystemUsers, sys)
          SystemGroup.synchronize(Aethyr::Linux::Interface::SystemGroups, sys)
#          ApplicationProcess.synchronize(Aethyr::Linux::Interface::ApplicationProcesses, sys)
#          ApplicationThread.synchronize(Aethyr::Linux::Interface::ApplicationThreads, sys)
#          Device.synchronize(Aethyr::Linux::Interface::Devices, sys)
#          UnixSocketTermination.synchronize(Aethyr::Linux::Interface::UnixSockets, sys)
#          NetworkSocketTermination.synchronize(Aethyr::Linux::Interface::NetworkSockets, sys)
#          PipeTermination.synchronize(Aethyr::Linux::Interface::Pipes, sys)
#          DiskPartition.synchronize(Aethyr::Linux::Interface::DiskPartitions, sys)
#          FileSystem.synchronize(Aethyr::Linux::Interface::FileSystems, sys)
#          FileTermination.synchronize(Aethyr::Linux::Interface::Files, sys)
#          SoftwarePackage.synchronize(Aethyr::Linux::Interface::SoftwarePackages, sys)
#          SoftwarePackageRepository.synchronize(Aethyr::Linux::Interface::SoftwarePackageRepositories, sys)
#          RubyGem.synchronize(Aethyr::Linux::Interface::RubyGems, sys)
#          RubyGemsEnvironment.synchronize(Aethyr::Linux::Interface::RubyGemsEnvironment, sys)
        end
  
      ######################################################################################################
      end  
      
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end
