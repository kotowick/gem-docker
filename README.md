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

## Usage

### Generate files
    $ rails g docker:install

**Files Generates:**
- ./config/docker/database/Dockerfile
- ./config/docker/project/Dockerfile
- ./config/docker/compose/docker-compose.yml

### Building Docker Images
    $ rake docker:build
For each Dockerfile in the ./config/docker/ path, it builds it into an image. It tags it with ```<DOCKER_PREFIX>/<APP_NAME>-<last_folder_name>```. I.E building ```./config/docker/project/Dockerfile``` would result in an image named ```<DOCKER_PREFIX>/<APP_NAME>-project```, where *APP_NAME* and *DOCKER_PREFIX* are envrionment variables set in your application.

### Running everything
    $ rake docker:up
This runs docker-compose with the input file located at ./config/docker/compose/docker-compose.yml. In that file, it specifies the containers to build.

### Clean up
    $ rake docker:clean
This removes all containers for this application.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kotowick/docker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
