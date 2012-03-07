require 'test_helper'

class Spree::AssetTest < ActiveSupport::TestCase

  setup do
    @asset = Spree::Asset.new
  end

  should "return true if asset has_alt?" do
    @asset.alt = "omg"
    assert_equal true, @asset.has_alt?
  end
  
  should "return false unless asset has_alt?" do
    assert_equal false, @asset.has_alt?
  end
  
end
