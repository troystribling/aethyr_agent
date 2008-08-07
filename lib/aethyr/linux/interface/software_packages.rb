############################################################################################################
module Aethyr

  ############################################################################################################
  module Linux
  
    ############################################################################################################
    module Interface
    
      ##########################################################################################################
      class SoftwarePackages
  
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

            pkgs = {}
            
            #### attributes other than description
            rows = `aptitude -w 300 -F "%p# %C# %M %t# %v# %V#" search '~i'`.split("\n")
            rows.each do |r|
              attrs = r.split(/\s+/)   
              pkg = self.send("build_hash_length_#{attrs.length}".to_sym, attrs)
              pkgs[pkg[:name]] = pkg
            end
            
            #### description
            rows = `aptitude -w 300 -F "%p# %d#" search '~i'`.split("\n")
            rows.each do |r|
              attrs = r.split(/\s+/)              
              pkgs[attrs[0]].update(:description => desc = attrs[1..attrs.length-1].join(' '))
            end

            pkgs.values

          end
    
          ##########################################################################################################
          def build_hash_length_6(attrs)
            get_automatic = lambda{attrs[2].eql?('A') ? true : false}
            {
             :name                => attrs[0], 
             :package_state       => attrs[1], 
             :automatic           => get_automatic[], 
             :repositories        => attrs[3].split(','), 
             :installed_version   => attrs[4], 
             :available_version   => attrs[5], 
            }
          end

          ##########################################################################################################
          def build_hash_length_5(attrs)
            {
             :name                => attrs[0], 
             :package_state       => attrs[1], 
             :automatic           => false, 
             :repositories        => attrs[2].split(','), 
             :installed_version   => attrs[3], 
             :available_version   => attrs[4], 
            }
          end

          ##########################################################################################################
          def build_hash_length_4(attrs)
            {
             :name                => attrs[0], 
             :package_state       => attrs[1], 
             :automatic           => false, 
             :repositories        => [], 
             :installed_version   => attrs[2], 
             :available_version   => attrs[3], 
            }
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
