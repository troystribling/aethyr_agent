namespace :aethyr do
  desc "build inventory database"
  task :inventory do
    require 'aethyr/os/linux/hardware_inventory'
    Aethyr::Linux::HardwareInventory.build_database
  end
end
