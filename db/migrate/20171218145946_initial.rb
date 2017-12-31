class Initial < ActiveRecord::Migration[5.1]
  def change
    create_table :configurations do |t|
      t.string :key
      t.string :value

      t.timestamps
    end

    create_table :topics do |t|
      t.string :name
      t.references :author, references: :users, foreign_key: { to_table: :topics }, index: true
      t.string :description
      t.integer :views, default: 0, index: true
      t.integer :replies, default: 0, index: true
      t.string :slug # Generated on record save for URL navigation

      t.timestamps
    end

    create_table :posts do |t|
      t.string :name
      t.string :content
      t.references :topic
      t.references :author, references: :users, foreign_key: { to_table: :posts }, index: true

      t.timestamps
    end

    create_table :tags do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    create_table :taggables do |t|
      t.references :topic
      t.references :tag

      t.timestamps
    end

    create_table :images do |t|
      t.string :file
      t.references :imagable
    end
  end
end
