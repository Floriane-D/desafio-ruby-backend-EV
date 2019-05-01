class CreateCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :competitions do |t|
      t.string :name
      t.string :unit
      t.boolean :finished, default: false
      t.string :criteria_to_win, default: :max
      t.integer :max_number_of_attempts, default: 1

      t.timestamps
    end
  end
end
