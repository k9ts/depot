require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures:products
  
  def new_product(image_url)
    Product.new(:title => "New Product",
                 :description => "Newest Product in our lineup",
                 :image_url => image_url,
                 :price => 1.00)
  end
  
  
  test "products attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end
  
  test "product price must be positive" do
    product = Product.new :title => "My book", :description => "Blah Blah", :image_url => "zzz.jpg"
    
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", 
      product.errors[:price].join('; ')
      
      
    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", 
      product.errors[:price].join('; ')
      
    product.price = 1
    assert product.valid?
  end
  
  test "image url must be gif/jpg/png" do
    ok = %w{ fred.gif fred.png fred.jpg fred.JPG fred.PnG http://a.b.c.d/fred.jpg }
    bad = %w{ fred.doc fred.gifi fred.jpg.more }
    
    ok.each do |name|
      assert new_product(name).valid?, "#{name} should be valid"
    end
    
    bad.each do |name|
      assert new_product(name).invalid?, "#{name} should be invalid"
    end
    
  end
end
