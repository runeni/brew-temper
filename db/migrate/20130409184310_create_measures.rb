class CreateMeasures < ActiveRecord::Migration
  def up
    create_table :measures do |t|
      t.string :temp
      t.timestamp :created_at
    end
  end

  def down
    drop_table :measures
  end
end
