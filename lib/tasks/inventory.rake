require 'config/environment'

namespace :aethyr do
  desc "build inventory database"
  task :inventory do
    System.synchronize(Aethyr::Linux::System)
    sys = System.find(:first)
    Memory.synchronize(Aethyr::Linux::Memory, sys)
    Cpu.synchronize(Aethyr::Linux::Cpu, sys)
    Nic.synchronize(Aethyr::Linux::Nic, sys)
  end
end
