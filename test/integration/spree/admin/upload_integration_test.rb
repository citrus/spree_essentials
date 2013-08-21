require "integration_test_helper"
require 'debugger'

class Spree::Admin::UploadIntegrationTest < SpreeEssentials::IntegrationCase

  def setup
    Spree::Upload.destroy_all
    @image  = File.expand_path("../../../../support/files/1.png", __FILE__)
    @image2 = File.expand_path("../../../../support/files/2.png", __FILE__)
    stub_authorization!
  end

  should "have a contents tab" do
    visit spree.admin_products_path
    within "#admin-menu" do
      assert has_link?("Content")
    end
  end

  should "get the uploads index" do
    visit spree.admin_uploads_path
    assert has_link?("new_image_link")
    within "#sub_nav" do
      assert has_link?("Uploads", :href => spree.admin_uploads_path)
    end
  end

  should "paginate the uploads index" do
    Spree::Config.set(:orders_per_page => 2)
    img = File.open(@image)
    3.times { |i|
      Spree::Upload.create(:attachment => img, :alt => "sample #{i + 1}")
    }
    visit spree.admin_uploads_path
    within ".pagination" do
      assert has_link?("2")
      click_link "2"
    end
    assert_seen "sample 1", :within => "table.index"
    assert_match /page\=2/, current_url
  end

  should "create an upload" do
    visit spree.admin_uploads_path
    click_link "new_image_link"
    attach_file "Attachment", @image
    within '[data-hook="admin_upload_form_fields"]' do
      fill_in "Description", :with => "Just an image"
    end
    click_button "Create"
    assert_equal spree.admin_uploads_path, current_path
    assert_flash :success, "Upload has been successfully created!"
  end

  context "with an existing upload" do
    setup do
      @upload = Spree::Upload.create(:attachment => File.open(@image), :alt => "Just an image!")
    end

    should "display the index" do
      visit spree.admin_uploads_path
      assert has_link?("1.png", :href => @upload.attachment.url(:original))
      assert_seen "Just an image!", :within => "tr#upload_#{@upload.id}"
      within "td.actions" do
        assert first("a.icon_link").native.attribute("href").include?(spree.edit_admin_upload_path(@upload))
        assert has_selector?("a.delete-resource")
      end
    end

    should "edit the upload" do
      visit spree.edit_admin_upload_path(@upload)
      assert_seen "Preview", :within => ".edit_upload p b"
      assert has_xpath?("//img[@src='#{@upload.attachment.url(:small)}']")
      attach_file "Attachment", @image2
      fill_in "Description", :with => "Just another image"
      click_button "Update"
      assert_equal spree.admin_uploads_path, current_path
      assert_flash :success, "Upload has been successfully updated!"
    end

    should "destroy the upload" do
      visit spree.admin_uploads_path
      assert_seen "Just an image!", :within => "tr#upload_#{@upload.id}"
      find("a.delete-resource").click
      page.driver.browser.switch_to.alert.accept
      assert_not_seen "Just an image!", :within => "tr#upload_#{@upload.id}"
      # assert_seen "Upload has been successfully removed!"
    end

  end

end
