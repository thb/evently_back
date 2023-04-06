class AddEndsAtToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :ends_at, :datetime
  end
end
