require_relative '../test_helper'

class UploadTest < Test::Unit::TestCase

  def setup
    Upload.destroy_all
    @jpgs = Dir["test/dummy/public/images/*.jpg"]
    @pngs = Dir["test/dummy/public/images/*.png"]
    @gifs = Dir["test/dummy/public/images/*.gif"]
  end
    
  should "validate attachment" do
    upload = Upload.new
    assert !upload.valid?
    assert !upload.save
  end
  
  should "create an upload" do
    count = Upload.count
    upload = Upload.new(:attachment => File.open(File.expand_path(@jpgs.shuffle.first)))
    assert upload.valid?
    assert upload.save
    assert_equal count + 1, Upload.count
  end
  
  context "with an existing upload" do 
    
    setup do
      @jpg = Upload.create(:alt => "jpg", :attachment => File.open(File.expand_path(@jpgs.shuffle.first)))
      @png = Upload.create(:alt => "png", :attachment => File.open(File.expand_path(@pngs.shuffle.first)))
      @gif = Upload.create(:alt => "gif", :attachment => File.open(File.expand_path(@gifs.shuffle.first)))
      
      @pdf = Upload.create(:alt => "pdf", :attachment => File.open(File.expand_path("../../dummy/public/test.pdf", __FILE__)))
      @zip = Upload.create(:alt => "zip", :attachment => File.open(File.expand_path("../../dummy/public/test.zip", __FILE__)))
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