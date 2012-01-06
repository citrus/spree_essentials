Change Log
----------

**0.3.2 - 2011/12/30**

* Safer decorator load path


**0.3.1 - 2011/12/13**

* Fix broken markitup editor
* Rework 'selected' class on content tab 


**0.3.0 - 2011/12/13**

* Upgrade to Spree 0.70.x
* Remove spork dependency


**0.2.3 - 2012/1/6**

* Removed automatic attachment config with SpreeHeroku [0.60.x]


**0.2.2 - 2011/7/22**

* Moved pagination above new image form


**0.2.1 - 2011/7/22**

* Added pagination to admin/uploads ... oops!


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