Spree Essentials
================

Spree Essentials is the base for many content related extensions for Spree. It doesn't do much on it's own ;)

Spree Essentials provides other extensions with:

* An easy markdown editor with ajax preview
* Image picker for embedding images into markdown editor

Current essential-aware extensions include:

* [spree_essential_cms](https://github.com/citrus/spree_essential_cms): A full featured CMS with pages, contents, images and more
* [spree_essential_blog](https://github.com/citrus/spree_essential_blog): A blog complete with archives, tags and related products
* [spree_essential_news](https://github.com/citrus/spree_essential_news): A news system, also complete with archives, tags and related products. (yes it's pretty much the exact same thing as the blog)
* [spree_essential_press](https://github.com/citrus/spree_essential_press): A simple press page for displaying media related content.



**ALL OF THESE UNDER DEVELOPMENT**



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
      require 'spree_essential_press/custom_hooks'
    else 
      SpreeEssentials.register :press, SpreeEssentialPress 
    end




Notes
-----

As I mentioned before, spree_essentials is still being developed... Development is being done on OSX with Ruby 1.9.2 and Spree 0.50.2.

Please let me know of any bugs you find or feature requests you'd like to see. 


Testing
-------

The test suite is very limited at the moment but can be run like so:

    git clone git://github.com/citrus/spree_essentials.git
    cd spree_essentials
    bundle install
    rake db:test_prep
    rake
    
    
You can also boot spork to run the tests much faster

    # in one window
    cd spree_essentials
    spork
    
    # in another window
    testdrb test/**/*_test.rb
    
    


To Do
-----

* more tests
* better documentation




Change Log
----------


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