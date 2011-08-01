ActiveRecord::Schema.define(:version => 0) do
  create_table :users, :force => true do |t|
    t.string :name
    t.integer :age
    t.references :remote
  end
  create_table :remotes, :force => true do |t|
    t.string :name
  end
  create_table :dogs, :force => true do |t|
    t.string :name
    t.references :user
  end
  create_table :toys, :force => true do |t|
    t.string :name
    t.references :dog
  end
end
