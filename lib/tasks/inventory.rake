require 'config/environment'

namespace :aethyr do
  desc "build inventory database"
  task :inventory do
    require 'aethyr/linux/inventory'
    Aethyr::Linux::Inventory.build_database
  end
end
