#! /usr/bin/env ruby
# encoding: UTF-8

require_relative '../../test_helper'

class AdminUploadIntegrationTest < ActiveSupport::IntegrationCase
  
  def setup
    Upload.destroy_all
    @image = File.expand_path("../../../../public/images/blog/rss.png", __FILE__)
    @image2 = File.expand_path("../../../../public/images/markitup/code.png", __FILE__)
  end
  
  should "have a contents tab" do
    visit admin_orders_path
    within "#admin-menu" do
      assert has_link?("Content")
    end
  end
  
  should "get the uploads index" do
    visit admin_uploads_path
    assert has_link?("new_image_link")
    within "#sub_nav" do
      assert has_link?("Uploads", :href => admin_uploads_path)
    end
  end
  
  should "create an upload" do
    visit admin_uploads_path
    click_link "new_image_link"
    attach_file "Attachment", @image
    fill_in "Description", :with => "Just an rss image"
    click_button "Create"
    assert_equal admin_uploads_path, current_path
    assert_flash :notice, "Upload has been successfully created!"
  end
  
  context "with an existing upload" do
    setup do 
      @upload = Upload.create(:attachment => File.open(@image), :alt => "Just an image!")
    end
  
    should "display the index" do
      visit admin_uploads_path
      assert has_link?("rss.png", :href => @upload.attachment.url(:original))
      assert_seen "Just an image!", :within => "tr#upload_#{@upload.id}"
      within "td.actions" do
        assert find("a.icon_link").native.attribute("href").include?(edit_admin_upload_path(@upload))
        assert has_selector?("a[href='#']")
      end
    end
    
    should "edit the upload" do
      visit edit_admin_upload_path(@upload)
      assert_seen "Preview", :within => ".edit_upload p b"
      assert has_xpath?("//img[@src='#{@upload.attachment.url(:small)}']")
      attach_file "Attachment", @image2
      fill_in "Description", :with => "Just another image"
      click_button "Update"
      assert_equal admin_uploads_path, current_path
      assert_flash :notice, "Upload has been successfully updated!"
    end
  
    should "destroy the upload" do
      visit admin_uploads_path
      find("a[href='#']").click
      find_by_id("popup_ok").click              
    end
    
  end
  
  
end
