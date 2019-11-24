class CreatePairHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :pair_histories do |t|
      t.references :member, index: true
      t.references :target, null: false, index: true, foreign_key: { to_table: :members }
      t.datetime :paired_at

      t.timestamps
    end
  end
end
