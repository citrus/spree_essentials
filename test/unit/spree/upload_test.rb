require 'test_helper'

class Spree::UploadTest < ActiveSupport::TestCase

  def setup
    Spree::Upload.destroy_all
    @jpgs = Dir[File.expand_path("../../../support/files/*.jpg", __FILE__)]
    @pngs = Dir[File.expand_path("../../../support/files/*.png", __FILE__)]
    @gifs = Dir[File.expand_path("../../../support/files/*.gif", __FILE__)]
  end
  
  should have_attached_file(:attachment)
  
  should "validate attachment" do
    upload = Spree::Upload.new
    assert !upload.valid?
    assert !upload.save
  end
  
  should "create an upload" do
    upload = Spree::Upload.new(:attachment => File.open(File.expand_path(@jpgs.shuffle.first)))
    assert upload.valid?
    assert_difference "Spree::Upload.count", +1 do
      assert upload.save
    end
  end
  
  context "with an existing upload" do 
    
    setup do
      @jpg = Spree::Upload.create(:alt => "jpg", :attachment => File.open(File.expand_path(@jpgs.shuffle.first)))
      @png = Spree::Upload.create(:alt => "png", :attachment => File.open(File.expand_path(@pngs.shuffle.first)))
      @gif = Spree::Upload.create(:alt => "gif", :attachment => File.open(File.expand_path(@gifs.shuffle.first)))
      @pdf = Spree::Upload.create(:alt => "pdf", :attachment => File.open(File.expand_path("../../../support/files/test.pdf", __FILE__)))
      @zip = Spree::Upload.create(:alt => "zip", :attachment => File.open(File.expand_path("../../../support/files/test.zip", __FILE__)))
    end
    
    should "be image content" do
      [@jpg, @png, @gif].each do |upload|
        assert upload.image_content?
      end
    end
    
    should "not be image content" do
      [@pdf, @zip].each do |upload|
        assert !upload.image_content?
      end
    end
    
  end
    
end