require 'config/environment'

namespace :aethyr do
  namespace :inventory do 
    desc "build inventory database"

    task :all do
      Aethyr::Linux::Inventory.synchronize
    end

    task :system do
      System.synchronize(Aethyr::Linux::Interface::System)
    end

    task :memory do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      Memory.synchronize(Aethyr::Linux::Interface::Memory, sys)
    end

    task :cpu do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      Cpu.synchronize(Aethyr::Linux::Interface::Cpu, sys)
    end

    task :nic do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      Nic.synchronize(Aethyr::Linux::Interface::Nic, sys)
    end

    task :system_users do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      SystemUser.synchronize(Aethyr::Linux::Interface::SystemUsers, sys)
    end

    task :system_groups do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      SystemGroup.synchronize(Aethyr::Linux::Interface::SystemGroups, sys)
    end

    task :application_processes do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      ApplicationProcess.synchronize(Aethyr::Linux::Interface::ApplicationProcesses, sys)
    end

    task :application_threads do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      ApplicationThread.synchronize(Aethyr::Linux::Interface::ApplicationThreads, sys)
    end

    task :devices do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      Device.synchronize(Aethyr::Linux::Interface::Devices, sys)
    end

    task :unix_sockets do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      UnixSocketTermination.synchronize(Aethyr::Linux::Interface::UnixSockets, sys)
    end

    task :network_sockets do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      NetworkSocketTermination.synchronize(Aethyr::Linux::Interface::NetworkSockets, sys)
    end

    task :network_interfaces do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      NetworkInterfaceTermination.synchronize(Aethyr::Linux::Interface::NetworkInterfaces, sys)
    end

    task :pipes do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      PipeTermination.synchronize(Aethyr::Linux::Interface::Pipes, sys)
    end

    task :disk_partitions do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      DiskPartition.synchronize(Aethyr::Linux::Interface::DiskPartitions, sys)
    end

    task :file_systems do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      FileSystem.synchronize(Aethyr::Linux::Interface::FileSystems, sys)
    end

    task :file_terminations do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      FileTermination.synchronize(Aethyr::Linux::Interface::Files, sys)
    end

    task :software_packages do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      SoftwarePackage.synchronize(Aethyr::Linux::Interface::SoftwarePackages, sys)
    end

    task :software_package_repositories do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      SoftwarePackageRepository.synchronize(Aethyr::Linux::Interface::SoftwarePackageRepositories, sys)
    end

    task :ruby_gems do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      RubyGem.synchronize(Aethyr::Linux::Interface::RubyGems, sys)
    end

    task :ruby_gems_environment do
      System.synchronize(Aethyr::Linux::Interface::System)
      sys = System.find_by_model(:first)
      RubyGemsEnvironment.synchronize(Aethyr::Linux::Interface::RubyGemsEnvironment, sys)
    end

  end
end
