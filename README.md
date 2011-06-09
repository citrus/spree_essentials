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

Spree Essentials hasn't been released to rubygems so you'll have to install it from the source. Just add the following to your Gemfile:

    gem 'spree_essentials', :git => 'git://github.com/citrus/spree_essentials.git'
  
    # Add any of the extensions you wish to use
  
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

**0.1.4 - 2011/6/9**

* Added faker.lorem.words to en.yml to prevent NoMethodError in integration tests


**0.1.3 - 2011/6/8**

* Added test in teardown to check for missing translations
* Removed some old bits of CMS code


**0.1.2 - 2011/6/7**

* Added missing translation
* Cleanup


**0.1.1 - 2011/6/7**

* Released 0.1.1
* Updated resource_controller.rb to Spree 0.60.0's and added `translated_object_name` method. ([pull request #419](https://github.com/spree/spree/pull/419) on Spree)
* Added upload integration test
* Cleaned up en.yml


**2011/6/6**

* Removed `spree_auth` requirement
* Added a few test helpers
* Updated readme


**0.1.0 2011/6/1**

* Added [dummier](https://github.com/citrus/dummier)
* Removed some remaining CMS bits


**2011/4/26**

* Modularized CMS. It can now be found [here](https://github.com/citrus/spree_essential_cms)


**2011/4/12**

* Added content contexts for multiple contents per page
* Namespaced posts into blog/posts
* Added `<!-- more -->` tag to posts


**2011/4/4**

* Added Page Images and starting to remove resource_controller.


**2011/4/3**

* Automatically adds [Heroku](http://heroku.com) support when you include [spree_heroku](https://github.com/paxer/spree-heroku) in your Gemfile. Check the [spree_heroku readme](https://github.com/paxer/spree-heroku#readme) for full installation instructions.
* Creates default content when you create a new page.

more in `CHANGELOG.md`


Contributors
------------

So far it's just me; Spencer Steffen. 

If you'd like to help out feel free to fork and send me pull requests!



License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.