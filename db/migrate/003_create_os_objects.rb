class CreateOsObjects < ActiveRecord::Migration

  def self.up

    create_table :system, :primary_key => :system_id, :force => true do |t|
      t.timestamps
    end

    create_table :memory, :primary_key => :memory_id, :force => true do |t|
      t.timestamps
    end

    create_table :cpus, :primary_key => :cpu_id, :force => true do |t|
      t.timestamps
    end

    create_table :nics, :primary_key => :nic_id, :force => true do |t|
      t.timestamps
    end

  end

  def self.down
    drop_table :system
    drop_table :memory
    drop_table :cpus
    drop_table :nics
  end
  
end
