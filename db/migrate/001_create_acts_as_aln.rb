class CreateActsAsAln < ActiveRecord::Migration

  def self.up

    #############################################################################################################
    #### aln infrastructure objects
    create_table :aln_resources, :force => true, :primary_key => :aln_resource_id do |t|
      t.integer :aln_resource_descendant_id
      t.string  :aln_resource_descendant_type
      t.integer :supporter_id    
      t.integer :support_hierarchy_root_id
      t.integer :support_hierarchy_left, :default => 1
      t.integer :support_hierarchy_right, :default => 2
      t.string  :name
    end
   
    create_table :aln_terminations, :force => true, :primary_key => :aln_termination_id do |t|
      t.integer :aln_termination_descendant_id
      t.string  :aln_termination_descendant_type
      t.integer :aln_connection_id   
      t.integer :aln_path_id   
      t.integer :termination_supporter_id   
      t.integer :network_id   
      t.integer :layer_id, :default => 0   
      t.string  :directionality
      t.string  :direction
    end
    
    create_table :aln_paths, :force => true, :primary_key => :aln_path_id do |t|
      t.integer :aln_path_descendant_id
      t.string  :aln_path_descendant_type
      t.string  :termination_type
    end

    create_table :aln_connections, :force => true, :primary_key => :aln_connection_id do |t|
      t.integer :aln_connection_descendant_id
      t.string  :aln_connection_descendant_type
      t.string  :termination_type
    end

    create_table :aln_network_ids, :force => true do |t|
      t.integer :network_id, :default => 0
    end
    
    create_table :resource_with_logs, :force => true, :primary_key => :resource_with_log_id do |t|
      t.integer :resource_with_log_descendant_id
      t.string  :resource_with_log_descendant_type
    end
    
  end

  def self.down
  
    drop_table :aln_resources
    drop_table :aln_terminations
    drop_table :aln_connections
    drop_table :aln_paths
    drop_table :aln_network_ids
    drop_table :resource_with_logs
    
  end
  
end