class CreateConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :connections do |t|
      t.bigint :user_id
      t.boolean :accepted?
      t.bigint :connected_user_id

      t.timestamps
    end
  end
end
