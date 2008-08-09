require 'yaml'

############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class RubyGemsEnvironment
  
        ######################################################################################################
        #### class methods
        class << self
  
          ########################################################################################################
          def find(type = :all, options = {})
            if type.eql?(:first)
            else
              self.find_all
            end
          end

        ######################################################################################################
        protected
    
          ##########################################################################################################
          def find_all

            genv = YAML::load(`gem environment`)['RubyGems Environment']

            config = {}
            genv[6]['GEM CONFIGURATION'].each do |c|
              key_val = /(.*)\s=>\s(.*)/.match(c.to_s).to_a
              config[key_val[1]] = key_val[2]
            end
            [{
              :name                   => 'gems',
              :gems_version           => genv[0]['RUBYGEMS VERSION'],
              :ruby_version           => genv[1]['RUBY VERSION'],
              :installation_directory => genv[2]['INSTALLATION DIRECTORY'],
              :ruby_executable        => genv[3]['RUBY EXECUTABLE'],
              :platforms              => genv[4]['RUBYGEMS PLATFORMS'],
              :gem_paths              => genv[5]['GEM PATHS'],
              :gem_configuration      => config,
              :remote_sources         => genv[7]['REMOTE SOURCES'],
            }]
          end

        ######################################################################################################
        end  
        
      ##########################################################################################################
      end
  
    ##########################################################################################################
    end

  ##########################################################################################################
  end
  
##########################################################################################################
end
