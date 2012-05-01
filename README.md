# Spree Essentials [![Build Status](https://secure.travis-ci.org/citrus/spree_essentials.png)](http://travis-ci.org/citrus/spree_essentials)

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
* [spree_essential_press](https://github.com/citrus/spree_essential_press): A simple press page for displaying media related content.


------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

If you don't already have an existing Spree site, [click here](https://gist.github.com/946719) then come back later... You can also read the Spree docs [here](http://spreecommerce.com/documentation/getting_started.html)...

Spree Essentials can be installed by itself by adding the following to your Gemfile:
    
```ruby
# Spree 1.1.x
gem 'spree_essentials', '~> 0.5.0'

# Spree 1.0.x
gem 'spree_essentials', '~> 0.4.0'

# Spree 0.70.x
gem 'spree_essentials', '~> 0.3.3'

# Spree 0.60.x
gem 'spree_essentials', '~> 0.2.3'
```

This isn't necessary if you're using spree_essentials based extensions. If that's the case, just include the extensions normally:

```ruby  
gem 'spree_essential_cms'
gem 'spree_essential_blog'
```
    
Then run:
    
```bash
bundle install
```

Once that's complete, run the migration generator and migrate your database:

To see your available generators run
 
```bash
rails g
```
    
Now run the generators for extensions you wish to install    

```bash 
rails g spree_essentials:install
rails g spree_essentials:cms
rails g spree_essentials:blog
```
    
Then migrate your database:

```bash
rake db:migrate
```

If that all went smoothly, you should be ready to boot the server with:

```bash
rails s
```

Now login to the admin and click on the 'Content' tab!




------------------------------------------------------------------------------
Deploying
------------------------------------------------------------------------------

Follow these steps if you plan host your attachments with a CDN like amazon s3. This is useful when deploying to [heroku](http://heroku.com).

First, add the [aws-sdk](http://rubygems.org/gems/aws-sdk) gem to your `Gemfile`

```ruby
gem 'aws-sdk', '~> 1.3'
```

Then run:

```bash
bundle install
```


Next, create some buckets on s3. I use the [s3cmd](http://s3tools.org/s3cmd).

```bash
s3cmd mb s3://yoursite.dev --acl-public
s3cmd mb s3://yoursite.com --acl-public
```


Now create a config file for s3 in `config/s3.yml`

```yml
# config/s3.yml
defaults: &defaults
  s3_protocol: http
  access_key_id: YOUR_KEY
  secret_access_key: YOUR_SECRET
  bucket: yoursite.dev

development:
  <<: *defaults

test:
  <<: *defaults

production:
  <<: *defaults
  bucket: yoursite.com
```


Lastly, create a [decorator](http://guides.spreecommerce.com/logic_customization.html) for the upload model in `app/models/spree/upload_decorator.rb`.

```ruby
# app/models/spree/upload_decorator.rb
Spree::Upload.attachment_definitions[:attachment].merge!(
  :storage        => 's3',
  :s3_credentials => Rails.root.join('config', 's3.yml'),
  :path           => "/uploads/:id/:style/:basename.:extension"
)
```


If you're using the [CMS](https://github.com/citrus/spree_essential_cms) or [blog](https://github.com/citrus/spree_essential_blog) extensions you can set the config on each model like so:

```ruby
# app/models/spree/asset_decorator.rb
[ Spree::Content, Spree::PageImage, Spree::PostImage, Spree::Upload ].each do |cls| 
  cls.attachment_definitions[:attachment].merge!(
    :storage        => 's3',
    :s3_credentials => Rails.root.join('config', 's3.yml'),
    :path           => "/:class/:id/:style/:basename.:extension"
  )
end
```


That's all there is to it!


------------------------------------------------------------------------------
Notes
------------------------------------------------------------------------------

Spree Essentials is under constant development... Development is being done on OSX with Ruby 1.9.3 and usually the latest version of Spree. (currently 1.1.0)

Please let me know if you find any bugs or have feature requests you'd like to see. 


------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

The test suite can be run like so:

```bash
git clone git://github.com/citrus/spree_essentials.git
cd spree_essentials
bundle install
bundle exec dummier
rake
```    

 
------------------------------------------------------------------------------
Demo
------------------------------------------------------------------------------

You can easily use the test/dummy app as a demo of spree_essentials. Just `cd` to where you develop and run:
  
```bash  
git clone git://github.com/citrus/spree_essentials.git
cd spree_essentials
cp test/dummy_hooks/after_migrate.rb.sample test/dummy_hooks/after_migrate.rb
bundle install
bundle exec dummier
cd test/dummy
rails s
```

 
------------------------------------------------------------------------------
To Do
------------------------------------------------------------------------------

* better documentation (you know you want to help!)


------------------------------------------------------------------------------
Change Log
------------------------------------------------------------------------------

**0.50.0 - 2012/5/1**

* Depend on Spree 1.1.0 
* Remove `add_attachment_file_size_to_assets` migration


**0.50.0.rc1 - 2012/4/11**

* Spree 1.1.x compatibility


**0.40.0 - 2012/4/11**

* Add Italian translation - (@iloveitaly)
* Add Russian translation - (@shaggyone)
* Release v0.40.0


**0.40.0.rc3 - 2012/3/7**

* Normalize upload attachment location
* Use rails engine conventions for installation
* Remove shared InstallGenerator class
* Improved test coverage
* Added test/spree_essential_example 


**0.40.0.rc2, 0.3.3 - 2012/1/20**

* Precompile admin assets in production


**0.4.0.rc1 - 2012/1/16**

* Add Spree 1.0.0 compatibility
* Breaks with previous versions of Spree


**0.3.2 - 2011/12/30**

* Safer decorator load path


**0.3.1 - 2011/12/13**

* Fix broken markitup editor
* Rework 'selected' class on content tab 


**0.3.0 - 2011/12/13**

* Upgrade to Spree 0.70.x
* Remove spork dependency


....more in [CHANGELOG.md](https://github.com/citrus/spree_essentials/blob/master/CHANGELOG.md)


------------------------------------------------------------------------------
Contributors
------------------------------------------------------------------------------

* Spencer Steffen ([@citrus](https://github.com/citrus))
* Michael Bianco ([@iloveitaly](https://github.com/iloveitaly))
* Victor Zagorski ([@shaggyone](https://github.com/shaggyone))


If you'd like to help out feel free to fork and send me pull requests!


------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2011 - 2012 Spencer Steffen & Citrus, released under the New BSD License All rights reserved.
