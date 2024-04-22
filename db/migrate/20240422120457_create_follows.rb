class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      # foreign_keyで外部キー制約
      #   意図しないユーザーIDが入らないようにしている
      #     to_tableキーの値で実際のテーブル名を指定
      # TODO : フォロー主のIDが入る
      t.references :follow, foreign_key: { to_table: :users }

      # foreign_keyで外部キー制約
      #   意図しないユーザーIDが入らないようにしている
      # TODO : フォロー先のIDが入る
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
