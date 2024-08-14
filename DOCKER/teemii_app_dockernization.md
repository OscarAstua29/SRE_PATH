# Deploying a Web app using docker from the terminal 
## Let's do this

For this example we are going to use the following images:

-Backend:  teemii-backend
-Frontend: teemii-frontend

Fisrt thing we need to do after getting the docker desktop, is to download the images previously mentioned from Docker hub using the following command:

    $docker pull dokkaner/teemii-frontend:develop
    $docker pull dokkaner/teemii-backend:develop

To verify that the images were downloaded correctly, run **docker images**

After that, we need a volume to storage all the data,  to create that, run the following commands:

        $docker volume create pgdata
        
Now let's run the volume in a container assigning a name, setting a enviroment password, specifying a port, and defining a path:

        $docker run --name teemii-volume -e POSTGRES_PASSWORD=12345 -d -p 5432:5432 -v  pgdata:/var/lib/postgresql/data postgres
        
Now we need a network to connect the backend with the frontend, to do that run the following commands:

    $docker network create teemii-network -d bridge
    
The flag bringe allow the communication between all the containers connected to the network.
    
Now let's create the fontend container, adding a name for the container, the port where you want to expose it, and also the backend image to create the frontend container, running the following command:

          $docker run --name=teemii-frontend -p 8080:80 -d dokkaner/teemii-frontend:develop 
    
In this case we us the  -d command to run the container on background and prevent it from blocking our terminal. 

Now you can verify that you container is running, by opening your favorite browser and typing on the search box **localhost:8080** that was the port that was assingned in the docker run command.

Now, lets create the backend container similary to the frontend, but in this case we'll add the volume that we already created to store the data.

        $docker run --name=teemii-backend --env=POSTGRES_HOST=postgres --env=POSTGRES_USER=postgres --env=POSTGRES_PASSWORD=12345 --env=POSTGRES_DB=postgres -p 3000:3000 -d dokkaner/teemii-backend:develop

Finally, let's connect the containers with the temmi-network already created.

        $docker network connect teemii-network postgres
        $docker network connect teemii-network teemii-backend
        $docker network connect teemii-network teemii-frontend

Something interesting: if you run the command **docker ps** you will see that the frontend container is not running, This happens, the frontend was trying to communicate with the backend but, didn't recive a respond that caused the frontend container to stop. To running it again, execute the following command:

     $docker start teemii-frontend

Now you can verify if the app is running by typping **localhost 8080** in you local browser address bar.
