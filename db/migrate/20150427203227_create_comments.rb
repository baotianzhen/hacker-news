class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :author
      t.references :commentable, polymorphic: true, index: true
      t.string :body

      t.timestamps
    end
  end
end
