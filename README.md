Spree Essentials
================

The swiss-army knife of spree extensions! Pages, Posts and Uploads implemented. Gallery coming soon!

** UNDER DEVELOPMENT BUT NEARING BETA! **


Installation
------------

** Assuming you already have an exisiting Spree site... ** ([click here](http://spreecommerce.com/documentation/getting_started.html) if you don't!)

Spree Essentials hasn't been released to rubygems so, you'll have to add the following to your Gemfile:

    gem 'spree_essentials', :git => 'git://github.com/citrus/spree_essentials.git'
    
    
Now run:
    
    bundle install


Once that's complete, run the migration generator and a db:migrate:

    rails g spree_essentials:install
    rake db:migrate


If that all went smoothly, you should be ready to boot the server with:

    rails s


Now login to the admin and click on the 'Content' tab!



To Do
-----

* more tests
* nested set for pages?
* ... there's got to be more...


License
-------

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.