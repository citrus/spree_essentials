copy_file "test.pdf", "public/test.pdf"
copy_file "test.zip", "public/test.zip"

# install spree and migrate db
rake "spree_core:install"
