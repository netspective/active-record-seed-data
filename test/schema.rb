ActiveRecord::Schema.define(:version => 1) do

  create_table :first_seed_data_test_table, :force => true do |t|
    t.string  :seed_name, :null => false
    t.string  :attr_1
    t.integer :attr_2
    t.boolean :attr_3
  end

  create_table :second_seed_data_test_table, :force => true do |t|
    t.string  :seed_name, :null => false
    t.string  :seed_scope
    t.string  :attr_1
    t.integer :attr_2
  end
  
end

