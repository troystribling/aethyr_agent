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

          #### Memory, Cpu
#          Memory.synchronize(Aethyr::Linux::Interface::Memory, sys, false)
#          Cpu.synchronize(Aethyr::Linux::Interface::Cpu, sys, false)
#
#          #### Nic, NetworkInterfaceTermination
#          Nic.synchronize(Aethyr::Linux::Interface::Nics, sys, false)
#          NetworkInterfaceTermination.synchronize(Aethyr::Linux::Interface::NetworkInterfaces, sys, false)
#          
          #### SystemGroup, SystemUser
          SystemUser.synchronize(Aethyr::Linux::Interface::SystemUsers, sys, false)
          SystemGroup.synchronize(Aethyr::Linux::Interface::SystemGroups, sys, false)

          #### Device
          Device.synchronize(Aethyr::Linux::Interface::Devices, sys, false)
                 
          #### ApplicationProcess, ApplicationThread
          ApplicationProcess.synchronize(Aethyr::Linux::Interface::ApplicationProcesses, sys, false)
#          ApplicationThread.synchronize(Aethyr::Linux::Interface::ApplicationThreads, sys, false)

#          UnixSocketTermination.synchronize(Aethyr::Linux::Interface::UnixSockets, sys, false)
#          NetworkSocketTermination.synchronize(Aethyr::Linux::Interface::NetworkSockets, sys, false)
#          PipeTermination.synchronize(Aethyr::Linux::Interface::Pipes, sys, false)
#          DiskPartition.synchronize(Aethyr::Linux::Interface::DiskPartitions, sys, false)
#          FileSystem.synchronize(Aethyr::Linux::Interface::FileSystems, sys, false)
#          FileTermination.synchronize(Aethyr::Linux::Interface::Files, sys, false)
#          SoftwarePackage.synchronize(Aethyr::Linux::Interface::SoftwarePackages, sys, false)
#          SoftwarePackageRepository.synchronize(Aethyr::Linux::Interface::SoftwarePackageRepositories, sys, false)
#          RubyGem.synchronize(Aethyr::Linux::Interface::RubyGems, sys, false)
#          RubyGemsEnvironment.synchronize(Aethyr::Linux::Interface::RubyGemsEnvironment, sys, false)
        end
  
      ######################################################################################################
      end  
      
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end
