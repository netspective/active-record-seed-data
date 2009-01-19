require File.dirname(__FILE__) + '/test_helper'

class FirstSeedDataTestTable < ActiveRecord::Base 
end

class SecondSeedDataTestTable < ActiveRecord::Base 
end

class SeedDataTest < Test::Unit::TestCase
    context "ActiveRecord" do
      should "respond to create_or_update_seed" do
        assert FirstSeedDataTestTable.respond_to?('create_or_update_seed')
      end
    end

    context "FirstSeedDataTestTable" do
      should "create the first seed row" do
        log = []
        record = FirstSeedDataTestTable.create_or_update_seed(:SEED => { :key => "seed_name", :log => log }, :seed_name => "ROW_1", :attr_1 => "ATTR_1 Test Value 01")
        assert_equal "Created FirstSeedDataTestTable seed for seed_name = ROW_1.", log[0]
        assert_equal "ATTR_1 Test Value 01", record.attr_1
      end

      should "update the first seed row" do
        log = []
        record = FirstSeedDataTestTable.create_or_update_seed(:SEED => { :key => "seed_name", :log => log }, :seed_name => "ROW_1", :attr_1 => "ATTR_1 Test Value 02", :attr_2 => "EVAL:1+1")
        assert_equal "Updated FirstSeedDataTestTable seed for seed_name = ROW_1.", log[0]
        assert_equal "ATTR_1 Test Value 02", record.attr_1
        assert_equal 2, record.attr_2
      end
    end

    context "SecondSeedDataTestTable" do
      should "create the first seed row with no scope" do
        log = []
        record = SecondSeedDataTestTable.create_or_update_seed(:SEED => { :keys => ["seed_name", "seed_scope"], :log => log }, :seed_name => "ROW_1", :seed_scope => nil, :attr_1 => "ATTR_1 Test Value 01")
        assert_equal "Created SecondSeedDataTestTable seed for seed_name, seed_scope = ROW_1, NULL.", log[0]
        assert_equal "ATTR_1 Test Value 01", record.attr_1
      end

      should "update the first seed row with no scope" do
        log = []
        record = SecondSeedDataTestTable.create_or_update_seed(:SEED => { :keys => ["seed_name", "seed_scope"], :log => log }, :seed_name => "ROW_1", :seed_scope => nil, :attr_1 => "ATTR_1 Test Value 02", :attr_2 => "EVAL:5*5")
        assert_equal "Updated SecondSeedDataTestTable seed for seed_name, seed_scope = ROW_1, NULL.", log[0]
        assert_equal "ATTR_1 Test Value 02", record.attr_1
        assert_equal 25, record.attr_2
      end

      should "create the first seed row with a scope" do
        log = []
        record = SecondSeedDataTestTable.create_or_update_seed(:SEED => { :keys => ["seed_name", "seed_scope"], :log => log }, :seed_name => "ROW_1", :seed_scope => 'SCOPE_1', :attr_1 => "ATTR_1 Test Value 01")
        assert_equal "Created SecondSeedDataTestTable seed for seed_name, seed_scope = ROW_1, SCOPE_1.", log[0]
        assert_equal "ATTR_1 Test Value 01", record.attr_1
      end

      should "update the first seed row with a scope" do
        log = []
        record = SecondSeedDataTestTable.create_or_update_seed(:SEED => { :keys => ["seed_name", "seed_scope"], :log => log }, :seed_name => "ROW_1", :seed_scope => 'SCOPE_1', :attr_1 => "ATTR_1 Test Value 02", :attr_2 => "EVAL:2+3")
        assert_equal "Updated SecondSeedDataTestTable seed for seed_name, seed_scope = ROW_1, SCOPE_1.", log[0]
        assert_equal "ATTR_1 Test Value 02", record.attr_1
        assert_equal 5, record.attr_2
      end
    end

end
