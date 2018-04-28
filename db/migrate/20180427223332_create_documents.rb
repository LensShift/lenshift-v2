class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :file
      t.string :desc

      t.timestamps
    end
  end
end
