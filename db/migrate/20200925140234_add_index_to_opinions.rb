class AddIndexToOpinions < ActiveRecord::Migration[6.0]
  def change
    add_index :opinions, :created_at
  end
end
