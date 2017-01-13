# Docker for OSX

This gem provides an easier approach to using docker-sync and docker-api to set up docker for local development. It solves the following issues:

- significantly reduces the I/O performance when mounting OSX volumes to Docker
- allows an easier/dynamic approach to building Docker images and running them with Docker Compose

***[View more notes here.](https://github.com/kotowick/gem-docker/wiki/6.-Notes)***

## Pre-reqs

- [download brew](http://brew.sh/)
- run: ```brew install fswatch```
- ```sudo echo '127.0.0.1 db' >> /etc/hosts```

## Installation

**For Rails Project**

Add this line to your application's Gemfile:

```ruby
gem 'docker', git: 'https://github.com/kotowick/gem-docker.git'
```

And then execute:

    $ bundle

**For Standalone Installation**

    $ gem install docker
    
***

**Required Environment Variables**

* **APP_NAME**: 'NAME_OF_YOUR_APPLICATION (i.e reports, management, store, etc)'

* **DOCKER_PREFIX**: 'PREFIX_FOR_DOCKER_IMAGES (example: company name)'

## Usage

### Generate files

    $ rails g docker:install

***[Learn more about the generated files, and what you need to do.](https://github.com/kotowick/gem-docker/wiki/2.-Generated-Files)***

### Building Docker Images

    $ rake docker:build
    
***[See instructions on how docker:build works with your project.](https://github.com/kotowick/gem-docker/wiki/3.-Building-Docker-Images)***

### Running everything

    $ rake docker:up

***[Learn more about how this works.](https://github.com/kotowick/gem-docker/wiki/4.-Run-it!)***

### Clean up

    $ rake docker:clean
    
This removes all containers for this application.

### More Commands

***[Check out other available commands.](https://github.com/kotowick/gem-docker/wiki/5.-More-Commands)***

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kotowick/gem-docker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
