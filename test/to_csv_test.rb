require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class ToCsvTest < Test::Unit::TestCase

  load_schema
  load_test_data
  @@users = User.all
  def setup
    #  @users = User.all
  end
  
  def test_schema_has_loaded_correctly
    assert_equal 2, User.count
    assert_equal 2, Dog.count
    assert_equal 1, Toy.count
    assert_equal 1, Remote.count
  end
  
  def test_with_empty_array
    assert_equal( "", [].to_csv )
  end

  def test_with_no_options
    assert_equal( "Remote,Name,Id,Age\n,Ary,1,25\n1,Nati,2,22\n", @@users.to_csv )
  end

  def test_with_no_headers
    assert_equal( ",Ary,1,25\n1,Nati,2,22\n", @@users.to_csv(:headers => false) )
  end

  def test_with_only
    assert_equal( "Name\nAry\nNati\n", @@users.to_csv(:only => :name) )
  end

  def test_with_empty_only
    assert_equal( "\n\n\n", @@users.to_csv(:only => "") )
  end

  def test_with_only_and_wrong_column_names
    assert_equal( "Name\nAry\nNati\n", @@users.to_csv(:only => [:name, :yoyo]) )
  end

  def test_with_except
    assert_equal( "Age\n25\n22\n", @@users.to_csv(:except => [:id, :name, :remote_id]) )
  end
  def test_with_except_and_only_should_listen_to_only
    assert_equal( "Name\nAry\nNati\n", @@users.to_csv(:except => [:id, :name], :only => :name) )
  end

  def test_with_method
    assert_equal( "Remote,Name,Is Old?,Id,Age\n,Ary,false,1,25\n1,Nati,false,2,22\n", @@users.to_csv(:methods => [:is_old?]) )
  end
  
  def test_with_include_singular
  end
  
  def test_with_include_singular_method
  end
  
  def test_with_include_singular_except
  end
  
  def test_with_nested_include_singular
  end
  
  def test_with_nested_include_singular_method
  end
  
  def test_with_nested_include_singular_except
  end
  
  def test_with_include_array
    assert_equal( "Age,Id,Name,Dog id,Dog name\n25,1,Ary,1,Rufus\n25,1,Ary,2,Scruffy\n22,2,Nati,,\n", @@users.to_csv(:include => :dogs) )
  end
  
  def test_with_include_array_method
    assert_equal( "Age,Id,Name,Dog id,Dog name, Dog bark?\n25,1,Ary,1,Rufus,true\n25,1,Ary,2,Scruffy,false\n22,2,Nati,,,\n", @@users.to_csv(:include => {:dogs => {:methods => [:bark]}}) )
  end
  
  def test_with_include_array_except
    assert_equal( "Age,Id,Name,Dog name\n25,1,Ary,Rufus\n25,1,Ary,Scruffy\n22,2,Nati,\n", @@users.to_csv(:include => {:dogs => {:except => [:id]}}) )
  end
  
  def test_with_nested_array_include
    assert_equal( "Age,Id,Name,Dog id,Dog name,Toy id,Toy name\n25,1,Ary,1,Rufus,1,Bone\n25,1,Ary,1,Rufus,2,Cookie\n25,1,Ary,2,Scruffy,1,Bone\n22,2,Nati,,,,\n", @@users.to_csv(:include => {:dogs => {:include => [:toy]}}) )
  end
  
  def test_with_nested_array_include_array_method
    assert_equal( "Age,Id,Name,Dog id,Dog name,Toy id,Toy name,Is wrecked?\n25,1,Ary,1,Rufus,1,Bone,false\n25,1,Ary,1,Rufus,2,Cookie,true\n25,1,Ary,2,Scruffy,1,Bone,false\n22,2,Nati,,,,,\n", @@users.to_csv(:include => {:dogs => {:include => {:toy => {:method => :is_wrecked?}}}}) )
  end
  
  def test_with_nested_array_include_array_except
    assert_equal( "Age,Id,Name,Dog id,Dog name,Toy name\n25,1,Ary,1,Rufus,Bone\n25,1,Ary,1,Rufus,Cookie\n25,1,Ary,2,Scruffy,Bone\n22,2,Nati,,,\n", @@users.to_csv(:include => {:dogs => {:include => {:toy => {:except => :id}}}}) )
  end
  
  #add some tests for a singular with a nested array
  
  #add some tests for an array with a nested singular
  
  
  
end
