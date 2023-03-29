class CreateFlats < ActiveRecord::Migration[7.0]
  def change
    create_table :flats do |t|
      t.string :external_id, null: false
      t.string :link
      t.jsonb :attr
      t.datetime :notified_at

      t.timestamps
    end
  end
end
