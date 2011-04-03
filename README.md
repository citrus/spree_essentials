Spree Essentials
================

The swiss-army knife of spree extensions!

** UNDER DEVELOPMENT BUT NEARING BETA! **


Features
--------

Included in Spree Essentials is a full blown CMS for pages, a blog complete with archives, tags and related products, and an admin for uploading your files. Uploaded files can be easily embedded into your pages or posts by using the included image picker. Page and post content is parsed with Markdown so formatting your content is a breeze. 



Installation
------------

** Assuming you already have an existing Spree site... ** ([click here](http://spreecommerce.com/documentation/getting_started.html) if you don't!)

Spree Essentials hasn't been released to rubygems so you'll have to install it from the source. Just add the following to your Gemfile:

    gem 'spree_essentials', :git => 'git://github.com/citrus/spree_essentials.git'
    
    
Now run:
    
    bundle install


Once that's complete, run the migration generator and migrate your database:

    rails g spree_essentials:install
    rake db:migrate


Since Spree doesn't have any hooks in the header you'll have to manually include the main menu. Just render the partial somewhere in your layout:

    <%= render 'shared/main_menu' %>
    

If that all went smoothly, you should be ready to boot the server with:

    rails s


Now login to the admin and click on the 'Content' tab!



Notes
-----

As I mentioned before, spree_essentials is still being developed but getting close to complete. Development has primarily been done on OSX with Ruby 1.9.2 and Spree 0.50.0.

Please let me know of any bugs you find or feature requests you'd like to see. 


Testing
-------

The test suite is a bit limited at the moment but can be run like so:

    git clone git://github.com/citrus/spree_essentials.git
    cd spree_essentials
    bundle install
    rake db:test_prep
    rake
    


To Do
-----

* allow page translations. (same contents associated to different languages)
* add homepage admin and front-end
* add widgets that you can drop into any page
* page and menu caching/sweeping
* more tests
* nested set for pages?


Ideas
-----

Develop other extensions to be 'essential-aware':

* Content related extensions (galleries/news/testimonials/etc) would reside in their own tab or under the 'Content' tab if it exists.
* Direct integration: When composing a message with [spree_mail](https://github.com/citrus/spree_mail), you'd have the same uploads helper and a helper for recent posts. 

Other:

* A 'create translation' button that clones the current page's contents into another language

License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.