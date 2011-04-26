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



**UNDER DEVELOPMENT**



Installation
------------

If you don't already have an existing Spree site, [click here](http://spreecommerce.com/documentation/getting_started.html) then come back later...

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

As I mentioned before, spree_essentials is still being developed but getting close to complete. Development has primarily been done on OSX with Ruby 1.9.2 and Spree 0.50.0.

Please let me know of any bugs you find or feature requests you'd like to see. 



Testing
-------

The test suite is very limited at the moment but can be run like so:

    git clone git://github.com/citrus/spree_essentials.git
    cd spree_essentials
    bundle install
    rake db:test_prep
    rake
    


To Do
-----

* modularize the cms into SpreeEssentialCms
* modularize the markdown editor to allow the blog and news extension to run on their own without the CMS
* allow page translations. (same contents associated to different languages)
* add page-parts like refinery
* add better homepage admin and front-end
* add widgets that you can drop into any page
* page and menu caching/sweeping
* more tests... many many more.
* nested set for pages
* 0.30 and 0.40 compatibility
* create wiki pages



Ideas
-----

Develop other extensions to be 'essential-aware':

* Direct integration: When composing a message with [spree_mail](https://github.com/citrus/spree_mail), you'd have the same uploads helper and a helper for recent posts. 

Other:

* A 'create translation' button that clones the current page's contents into another language



Change Log
----------


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