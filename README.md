Spree Essentials
================

Spree Essentials is the base for many content related extensions for Spree. It doesn't do much on it's own ;)

Spree Essentials provides other extensions with:

* An asset-upload interface
* An easy markdown editor with ajax preview
* Image picker for embedding uploaded images into markdown editor
* A common navigation tab ("Content")
* A shared `test_helper.rb`

Current essential-aware extensions include:

* [spree_essential_cms](https://github.com/citrus/spree_essential_cms): A full featured CMS with pages, contents, images and more
* [spree_essential_blog](https://github.com/citrus/spree_essential_blog): A blog complete with archives, categories, tags and related products
* [spree_essential_news](https://github.com/citrus/spree_essential_news): A news system, also complete with archives, tags and related products. (yes it's pretty much the exact same thing as the blog)
* [spree_essential_press](https://github.com/citrus/spree_essential_press): A simple press page for displaying media related content.



Installation
------------

If you don't already have an existing Spree site, [click here](https://gist.github.com/946719) then come back later... You can also read the Spree docs [here](http://spreecommerce.com/documentation/getting_started.html)...

Spree Essentials can be installed by itself by adding the following to your Gemfile:

    gem 'spree_essentials', '>= 0.2.3'
  
This isn't necessary if you're using spree_essentials based extensions. If that's the case, just include the extensions normally:
  
    gem 'spree_essential_cms', :git => 'git://github.com/citrus/spree_essential_cms.git'
    gem 'spree_essential_blog', :git => 'git://github.com/citrus/spree_essential_blog.git'
  
    
Then run:
    
    bundle install


Once that's complete, run the migration generator and migrate your database:

To see your available generators run
 
    rails g
 
    
Now run the generators for extensions you wish to install    
 
    rails g spree_essentials:install
    rails g spree_essentials:cms
    rails g spree_essentials:blog
 
    
Then migrate your database:
    rake db:migrate


If that all went smoothly, you should be ready to boot the server with:

    rails s


Now login to the admin and click on the 'Content' tab!



Essential Awareness
-------------------

Spree Essentials is designed to allow other extensions to reside under it's global 'Content' tab in the admin. [SpreeEssentialPress](https://github.com/citrus/spree_essential_press) is the first of many extensions that can run with or without spree_essentials installed.

Setting up an essential aware extension is easy. In your `lib/[extension_name].rb` file, add something like this:


    module SpreeEssentialPress
      
      def self.tab
        [:press, { :route => :admin_press_index }]
      end
      
      def self.sub_tab
        [:press, { :route => :admin_press_index, :label => 'admin.subnav.press', :match_path => '/press' }]
      end
      
      def self.independent?
        return true unless defined?(SpreeEssentials)
        !SpreeEssentials.respond_to(:register)
      end
    
    end
    
    if SpreeEssentialPress.independent?
      # your own admin tab would be here
      require 'spree_essential_press/custom_hooks'
    else 
      # register with Spree Essentials and reside under the "Content" tab
      SpreeEssentials.register :press, SpreeEssentialPress 
    end




Notes
-----

Spree Essentials is under constant development... Development is being done on OSX with Ruby 1.9.2 and usually the latest version of Spree. (currently 0.60.0)

Please let me know if you find any bugs or have feature requests you'd like to see. 


Testing
-------

The test suite is very limited at the moment but can be run like so:

    git clone git://github.com/citrus/spree_essentials.git
    cd spree_essentials
    bundle install
    bundle exec dummier
    rake
    

You can also boot spork to run the tests much faster

    # in one window
    cd spree_essentials
    spork
    
    # in another window
    testdrb test/**/*_test.rb
    
    
Demo
----

You can easily use the test/dummy app as a demo of spree_essentials. Just `cd` to where you develop and run:
    
    git clone git://github.com/citrus/spree_essentials.git
    cd spree_essentials
    mv lib/dummy_hooks/after_migrate.rb.sample lib/dummy_hooks/after_migrate.rb
    bundle install
    bundle exec dummier
    cd test/dummy
    rails s
    
    
    

To Do
-----

* more tests
* better documentation



Change Log
----------

**0.2.3 - 2012/1/6**

* Removed automatic attachment config with SpreeHeroku 


**0.2.2 - 2011/7/22**

* Moved pagination above new image form


**0.2.1 - 2011/7/22**

* Added pagination to admin/uploads


**0.2.0 - 2011/7/14**

* Depend on Spree 0.60.x and above
* Remove spree_auth dependency
* Removed `app/controllers/admin/resource_controller.rb` in favor of the Spree Default one
* Updated development gems to most recent versions


**0.1.4 - 2011/6/10**

* Removed console.log from jquery.autodate.js
* Updated resource controller with better flash message handling
* Added faker.lorem.words to en.yml to prevent NoMethodError in integration tests


**0.1.3 - 2011/6/8**

* Added test in teardown to check for missing translations
* Removed some old bits of CMS code

....more in [CHANGELOG.md](https://github.com/citrus/spree_essentials/blob/master/CHANGELOG.md)


Contributors
------------

So far it's just me; Spencer Steffen. 

If you'd like to help out feel free to fork and send me pull requests!



License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.