class CreateBooks < ActiveRecord::Migration[5.2]
  def change

    create_table :books do |t|
      t.string :name
      t.integer :price
      t.date :release_date

      t.timestamps
    end

    create_table :book_tags do |t|
      t.references :book, foreign_key: true
      t.string :name

      t.timestamps
    end

    create_table :book_reviews do |t|
      t.references :book, foreign_key: true
      t.string :comment
      t.integer :star_rating

      t.timestamps
    end

  end
end
