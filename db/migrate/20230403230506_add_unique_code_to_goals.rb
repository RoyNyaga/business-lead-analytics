class AddUniqueCodeToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :unique_code, :string
  end
end
