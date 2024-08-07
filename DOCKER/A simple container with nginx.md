# A simple container with Nginx
## Let's create a simple container with docker

Fisrt thing we need to do after get the docker desktop, is to download the Nginx image from Docker hub using the following command:

    
    $docker pull nginx


After that write on your fav terminal the command **docker run** adding a name, the port where you want to expose it, and obviusly the image of Nginx: 

    $docker run -name a_simple_conteiner_Nginx -d -p 8080:80 nginx
    
In this case we us the  -d command to run the container on background and prevent it from blocking our terminal. 

Now you can verify that you container is running, by opening your favorite browser and typing on the search box **localhost:8080** that was the port that was assingned in the docker run command.
