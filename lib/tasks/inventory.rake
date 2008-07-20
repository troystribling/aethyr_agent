require 'config/environment'

namespace :aethyr do
  desc "build inventory database"
  task :inventory do
    Aethyr::Linux::Inventory.synchronize
  end
end
