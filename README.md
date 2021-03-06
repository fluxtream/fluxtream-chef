# WARNING: THIS IS NOT BEING MAINTAINED ANYMORE, IS UNSAFE AND BUGGY - USE AT YOUR OWN RISK

# Build and run fluxtream on a production machine - total time ~45 minutes

As a prerequisite, please execute the steps described [here](https://help.github.com/articles/generating-ssh-keys)

ssh to your brand new machine and do the following:

	sudo apt-get install git
	sudo apt-get install curl
	curl -L http://opscode.com/chef/install.sh | sudo bash
	git clone https://github.com/fluxtream/fluxtream-chef.git
	cd fluxtream-chef
	git submodule init
	git submodule update
	chmod +x soloconfig.sh
	./soloconfig.sh
	sudo chef-solo -N fluxtream_prod -j node.json -c solo.rb

Count ~10 minutes… Now you are ready to build. First scribe-java:

	sudo su fluxtream
	cd /home/fluxtream/projects/scribe-java
	mvn install
	cd /home/fluxtream/projects/fluxtream-app
	mvn -DskipTests=true clean install
	
Building Fluxtream for the first time is quite a lengthy process as maven needs to (recursively) download all the jar dependencies for the project; count ~15-20 minutes. 

The last step is to edit the property files

	cd /home/fluxtream/projects/fluxtream-app/src/main/resources
	
The files to edit are `common.properties`, `local.properties` and `oauth.properties`

Finally , start tomcat:

	/etc/init.d/tomcat7 start
	
Head to `http://yourserver:8080/`

# Create a development environment - total time: ~ 1 hour

## Requirements

Install java, maven, git on your development machine

## Clone fluxtream-app on Github

This is the main repository for fluxtream's source code.

	git clone git@github.com:fluxtream/fluxtream-app.git

Now install missing maven dependencies

	cd <fluxtream-app_root>/maven
	chmod +x install.sh
	./install.sh

## Install Virtualbox

Vagrant depends on Virtualbox for its ability to create virtual machines.

Head to [VirtualBox Downloads](https://www.virtualbox.org/wiki/Downloads)

## Install Vagrant

Now you need to install vagrant. Go to [Vagrant downloads](http://downloads.vagrantup.com/)

## Clone fluxtream-chef on Github

[Fluxtream-chef](https://github.com/fluxtream/fluxtream-chef) is basically a collection of chef recipes used to provision a complete environment for running fluxtream.

	git clone git@github.com:fluxtream/fluxtream-chef.git
	
Fluxtream-chef also contains a `Vagrantfile` sample file that you can use to provision your own development instance.

	cd <fluxtream-chef_root>/vagrant
	mv Vagrantfile.sample.rb Vagrantfile
	
Now find the synced folders section and modify it according to your file layout

	config.vm.synced_folder "/Users/foo/projects", "/home/work"
	
i.e. This example would work if fluxtream-app was checked out under `/Users/foo/projects` on your machine

## Vagrant up

In `<fluxtream-chef_root>/vagrant`, do:

	vagrant up
	
Sit back and relax while your virtual machine is being built by vagrant (~5-10 minutes)

## Build fluxtream

	(temporary) git checkout -b idempotent_updates origin/idempotent_updates
	cd <fluxtream-app_root>
	mvn -DskipTests=true clean install
	
The first time you run this, maven will download all required jar dependencies, which will take a while (~10-20 minutes); after that it can take between 10 and 30 seconds. Use JRebel (see below) to avoid recompilation.

## Start tomcat

Connect to your vm:

	vagrant ssh
	
Start tomcat:

	sudo /etc/init.d/tomcat7 start

## Enjoy fluxtream in your browser

Surf to [http://localhost:8282/](http://localhost:8282/)

## (optional) Make it work with JRebel

JRebel has to live in your synched folder: `/Users/foo/projects/JRebel/` (this is where the JRebel agent will look for jrebel.jar)

Instead of starting tomcat with `/etc/init.d`, do (in your vm's console)

	sudo su
	cd /usr/share/tomcat
	bin/catalina-jrebel.sh jpda start

## Debugging

If you started tomcat with the `catalina-jrebel.sh` script there's a jpda service listening on port 9000
