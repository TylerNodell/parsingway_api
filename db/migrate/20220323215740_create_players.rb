class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :server
      t.string :fflogs_Id

      t.timestamps
    end
  end
end
