# install spree and migrate db
run "rake spree_core:install"
run "rails g spree_essentials:install"

copy_file "test.pdf", "public/test.pdf"
copy_file "test.zip", "public/test.zip"
