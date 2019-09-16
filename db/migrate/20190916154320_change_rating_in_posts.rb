class ChangeRatingInPosts < ActiveRecord::Migration[5.2]
  def up
    change_column :posts, :rating, :decimal, default: 0
  end

  def down
    change_column :posts, :rating, :decimal, precision: 5, scale: 4, default: 0
  end
end
