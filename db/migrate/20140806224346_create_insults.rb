class CreateInsults < ActiveRecord::Migration
  def change
    create_table :insults do |t|
      t.string :eating_what
      t.string :phrase

      t.timestamps
    end
  end
end
