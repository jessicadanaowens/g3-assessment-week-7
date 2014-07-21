class Users < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.string :message
    end
  end

  def down
    # add reverse migration code here
  end
end
