# HOSTING OF BMI CALCULATOR APPLICATION IN REACT
### CHALLENGE WEEK2

#### 1- Initialize Vagran ubuntu/bionic64

Create a Vagrantfile, open it with nano, and copy the following configuration:

    # -- mode: ruby --
    # vi: set ft=ruby :

    # All Vagrant configuration is done below. The "2" in Vagrant.configure
    # configures the configuration version (we support older styles for
    # backwards compatibility). Please don't change it unless you know what
    # you're doing.
    Vagrant.configure("2") do |config|

    config.vm.box = "ubuntu/bionic64"
    config.vm.network "private_network", ip: "192.168.56.10"

    end
    
Remember use ctrl + o to write out, and ctrl + x to exit.

Now Start the vagrant and enter to de VM

    vagrant up
    vagrant ssh
#### 2- Prepare the react application

Here, we need to use nvm to make some configurations, so lets install it:


    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    
Now install npm and node, using nvm:

        nvm install 16

        nvm use 16
        
To run de app, we need to clone a repository, so lets install git:

    sudo apt install git
    
Now, lets clone de repository with the following command:

    git clone https://github.com/falconcr/react-demo

Now, open the react-demo directory,and compile the app, to do that, run the following commands:


    cd react-demo
    npm install
    npm run build
    
    

#### 2- Ngnix configuration

To install Nginx run the following commands:


        sudo apt-get update
        sudp apt-get install nginx

Now, move to the next root, and create a file call react-demo:

        cd /etc/nginx/sites-available
        
        sudo nano react-demo

Now, copy the following lines:

        server {
    listen 80;
    server_name example.com;  # Instead of use example.com you can change it to your name

    root /here, write the root of your react-demo directory/react-demo/build; in my case root /react-demo/build)
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
    }


Press ctrl + o to write out and ctrl + x to exit

Now, lets create an a symbolic link between the sites-available and sites-enebled to enable the configuration:

        sudo ln -s /etc/nginx/sites-available/react-demo /etc/nginx/sites-enabled/
        
Finally, restar the Nginx tu apply the changes:

        sudo systemctl restart nginx

##4-Open your browser and write the ip host 192.168.56.10
Now if you can see the react app, everyting is ok, congrats.
