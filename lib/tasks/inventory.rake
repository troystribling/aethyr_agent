namespace :aethyr do
  desc "build inventory database"
  task :inventory do
    require 'aethyr/os/ubuntu/hw'
    Aethyr::PublicImageDb.synchronize
  end
end
