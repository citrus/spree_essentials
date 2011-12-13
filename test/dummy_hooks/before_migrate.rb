# install spree and migrate db
run "rails g spree:site"
run "rails g spree_essentials:install"

copy_file "test.pdf", "public/test.pdf"
copy_file "test.zip", "public/test.zip"
