# silverstripe-nginx

## What does the project do?

It provides a self-contained box running [SilverStripe](http://www.silverstripe.org).
You can use it to:

* Start playing around with SilverStripe without any prior experience.
* Create a new project without the hassle of setting anything up.
* Use it as a template for your setup with Ubuntu 14.04, nginx, and PHP-FPM.


## How do you install it?

You neet a working [Vagrant](http://www.vagrantup.com) installation.
If you can successfully run ``$ vagrant -v`` you are most likely good to continue.


## How do you use it?

Open your shell and change to the base folder of this project where the *Vagrantfile* is located.
Run ``$ vagrant up`` and it will pull down Ubuntu 14.04, install all required dependencies, and install the latest stable SilverStripe version.


## How do you make sure it works?

Open your browser and go to [http://127.0.0.1:8888](http://127.0.0.1:8888).
You should see SilverStripe's default theme with the header text "Your Site Name".


## How can you get involved?

If something is not working as expected, you have an improvement, or need a feature — please [open a ticket](https://github.com/xeraa/silverstripe-nginx/issues).


## What is the motivation for the project?

Make it as easy as possible to get started with SilverStripe and nginx.
You can simply use it as it is or you can take a look at the configuration to create your own setup.
