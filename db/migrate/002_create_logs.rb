class CreateLogs < ActiveRecord::Migration

  def self.up

    create_table :logs, :primary_key => :log_id, :force => true do |t|
      t.column :log_descendant_id, :integer
      t.column :log_descendant_type, :string
      t.column :resource_with_log_id, :string
      t.column :name, :string
      t.column :created_at, :datetime
    end

    create_table :access_logs, :primary_key => :access_log_id, :force => true do |t|
      t.column :action, :string
      t.column :controller, :string
      t.column :uri, :string
      t.column :ip_address, :string
      t.column :session, :string
      t.column :session_start, :string
      t.column :dns_name, :string
      t.column :http_user_agent, :string
      t.column :http_referer, :string
      t.column :parameters, :string
    end

    create_table :alarm_logs, :primary_key => :alarm_log_id, :force => true do |t|
      t.column :model, :string
      t.column :name, :string
      t.column :description, :string
    end

  end

  def self.down
    drop_table :logs
    drop_table :access_logs
    drop_table :alarm_logs
  end
  
end
