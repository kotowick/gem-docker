# Docker for OSX

This gem provides an easier approach to using docker-sync and docker-api to set up docker for local development. It solves the following issues:

- significantly reduces the I/O performance when mounting OSX volumes to Docker
- allows an easier/dynamic approach to building Docker images and running them with Docker Compose

### Notes
- At the time of this writing, docker-api is meant to interface with Docker version 1.3.*
- This is only intended for OSX (at the moment)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'docker', git: 'https://github.com/kotowick/gem-docker.git'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install docker

Now, install fswatch

    $ brew install fswatch

To access your docker database from your local machine, add this to /etc/hosts:

    $ sudo echo '127.0.0.1 db' >> /etc/hosts

## Usage

### Generate files
    $ rails g docker:install

**Files Generates:**
- ./config/docker/database/Dockerfile
- ./config/docker/project/Dockerfile
- ./config/docker/compose/docker-compose.yml

These files are examples, feel free to change them as needed. There are some "variables" in CAPS which the gem reads and changes based on your environment settings.

### Environment settings
Please have these variables set in your environment:

- APP_NAME # the unique name of your application
- DOCKER_PREFIX # prefix of the docker image

### Building Docker Images
    $ rake docker:build

For each Dockerfile in the ./config/docker/ path, it builds it into an image. It tags it with ```<DOCKER_PREFIX>/<APP_NAME>-<last_folder_name>```. I.E building ```./config/docker/project/Dockerfile``` would result in an image named ```<DOCKER_PREFIX>/<APP_NAME>-project```, where *APP_NAME* and *DOCKER_PREFIX* are environment variables set in your application.

### Running everything
    $ rake docker:up # builds the docker-compose file at ./config/docker/compose/docker-compose.yml

### Clean up
    $ rake docker:clean # remove all related containers

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kotowick/docker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
