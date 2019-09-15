class AddMarksAmountToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts,:marks_amount, :integer, default: 0
  end
end
