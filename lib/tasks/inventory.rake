namespace :aethyr do
  desc "build inventory database"
  task :inventory do
    require 'aethyr/os/ubuntu/hardware_inventory'
    Aethyr::Ubuntu.synchronize
  end
end
