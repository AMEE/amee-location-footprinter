# CICO2 

With this app, you're able to sign in with your Foursquare account, and see the cumulative carbon footprint of your travels from checkin to checkin in your Foursquare history.

## How to set this up

Being a Rails 3 app, this we rely on later versions than the current official releases of the AMEE gems, in particular, `amee-ruby`, `amee-data-persistence`, and `amee-data-abstraction`. 

So, we'll have to run through a few steps beforehand to make sure we have a compatible set of gems available to us.

### Getting the right versions of `amee-ruby`, `amee-data-persistence`, and `amee-data-abstraction`

First we need to checkout our gems from git. In our ~/AMEE-Code (or equivalent) directory, run:

git clone https://github.com/AMEE/amee-ruby
git clone git@github.com:AMEE/amee-data-persistence.git
git clone git@github.com:AMEE/amee-data-abstraction.git

Now, these gems need to be build in a specific order; `amee-data-abstraction`, then `amee-data-persistence`, then finally `amee-ruby`.

In each case, to stop us fetching the wrong version of the from a remote server, we need to build and install the gem locally.

#### Building and install `amee-data-abstraction`

Before we install the gem locally, we need to be sure we're on the correct branch, and and have the correct dependencies, before building the gem:

    cd amee-data-abstraction-
    git checkout rails 3
    bundle install

Once we have this, we can then build the gem, and install it into the current gemset. Calling `gem install` with a given path like this overrides the normal behaviour of looking for pre-installed gem, or checking remotely for it.

    rake build 
    gem install ./pkg/amee-data-abstraction-1.1.0.gem

#### Building and install `amee-data-persistence`

We need to repeat the same process for the other two gems now:

    cd ../amee-data-persistence-
    git checkout rails 3
    bundle install
    rake build 
    gem install ./pkg/amee-data-persistence-1.1.0.gem

And finally do the same for the `amee-ruby` gem, which depends on the other two gems:

cd ../amee-ruby-
git checkout rails 3
bundle install
rake build 
gem install ./pkg/amee-3.0.1.gem

With the other gems in place, we can now go back to the root of _this_ app, and run bundle install. Because our newer versions have been installed, bundler will default to using them than the official releases it would normally use.


