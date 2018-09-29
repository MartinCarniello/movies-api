class CreateMoviesPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_people do |t|
      t.integer :type_cd
      t.belongs_to :movie, index: true
      t.belongs_to :person, index: true

      t.timestamps
    end
  end
end
