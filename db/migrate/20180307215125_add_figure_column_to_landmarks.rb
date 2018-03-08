class AddFigureColumnToLandmarks < ActiveRecord::Migration[5.1]

  def change
    add_column :landmarks, :figure, :string
  end

end
