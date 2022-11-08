# Time manager

Time manager is a simple app to register work sessions.
<p>&nbsp;</p>

# API set-up
## <strong>Installation</strong>

### <strong> Linux (WSL2) installation : </strong>

The lastest versions of Elixir (1.13.4) and Erlang/OTP 25 has to be install as follow :


### 1. Retrieved latest package version for Elixir and Erlang
```bash
$ wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
```
### 2. Update the packages
```bash
$ sudo apt update
```
### 3. Retrieved latest package version for Elixir and Erlang
```bash
$ sudo apt update
```
### 4. Retrieved latest package version for Elixir and Erlang
```bash
$ sudo apt install esl-erlang
```
### 5. Retrieved latest package version for Elixir and Erlang
```bash
$ sudo apt install elixir
```

### 6. Checkout the Elixir version, you should see :
```bash
$ elixir --version
Erlang/OTP 25 [erts-13.0.4] [source] [64-bit] [smp:12:12] [ds:12:12:10] [async-threads:1] [jit:ns]

Elixir 1.13.4 (compiled with Erlang/OTP 25)
```
### 7. Here's the command to install Hex (If you have Hex already installed, it will upgrade Hex to the latest version):
```bash
$ mix local.hex
```
### 8. Once we have Elixir and Erlang, we are ready to install the Phoenix application generator:
```bash
$ mix archive.install hex phx_new
```

<p>&nbsp;</p>

## <strong>Fisrt set-up</strong>

### <strong>Creating Phoenix application</strong>

### 1. Once you have everything installed you're ready to generate new Phoenix project by executing:
```bash
$ mix phx.new api
```

<p>&nbsp;</p>

## <strong>Docker set-up</strong>

### <strong>Prerequires: </strong>
You need to have install Docker Desktop and had link your Linux subsystem to docker Desktop in the parameters : Ressources --> WSL Integration --> Enable integration with additional distros:


### <strong>Build the docker images from the ground :</strong>

### 1. First we need to build our Docker image:
```bash
$ docker-compose up --build
```
### 2. Go to config/dev.ex and change the content for your database by this:
```bash
# Configure your database
config :myapp, Myapp.Repo,
  url: System.get_env("DATABASE_URL"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

### 3. Update your endpoint IP to 0.0.0.0
```bash
config :time_manager, TimeManagerWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {0, 0, 0, 0}, port: 4000],
```

### 4. Create a database to connect:
```bash
$ docker-compose run api mix ecto.create
```

### 5. Launch docker !
```bash
$ docker-compose up
```

<p>&nbsp;</p>

## <strong>Connect to the admin</strong>


### <strong>Build the docker images from the ground :</strong>

### 1. First go to : http://localhost:5555/

### 2. Connect using user and password from the docker-compose.yml file : 
- PGADMIN_DEFAULT_EMAIL : admin@admin.org
- PGADMIN_DEFAULT_PASSWORD : admin

### 3. Add a new server : 
- Click on "Add a new server" in the main page

### 4. Fill the field in the server config "General" tab : 
- Name : time_manager_db (your_db_name)

### 5. After that, click on the "Connection" tab : 
Here you need the IPAdress of your db container. 
Go to docker desktop and copy the id of the container and run : 
```bash
$ docker inspect <id_the_db_container>
```
After retrieving the IPAdress of the container fill : 
- Hostname/adress : <id_the_db_container>
- Port : <your_container_db_port_in_the_dokcer-compose.yml>
- Maintenance database : postgres
- Username : <username_in_the_DATABASE_URL>
- Password : <password_in_the_DATABASE_URL>

You're now connected !!! Congrats

<p>&nbsp;</p>

## <strong>Docker usage</strong>

### <strong>From now you need to execute every command from Elixir and Phoenix from docker !!</strong>

### 1. For instance, this command... 
```bash
$ mix ecto.migrate
```
### ... is now this !
```bash
$ docker-compose run web mix ecto.migrate
```

Warning: "web" is the name of the container that include our API

So commands follows now this schema : 
### ... is now this !
```bash
$ docker-compose run container_name <command>
```

### 2. Stop containers from running : 
```bash
$ docker-compose stop
```

### 2. Remove containers and images (rollback to the state before the build) : 
```bash
$ docker-compose down -v
```

### 2. Restart the containers : 
```bash
$ docker-compose up -d
```

"-d" flag allow to not get the logs in the terminal

<p>&nbsp;</p>

## <strong>Docker usage for production</strong>


### 1. Build no cache prod  :  
```bash
$ docker-compose -f docker-compose-prod.yml -p prod build --no-cache
```

### 2. Up prod containers  :  
```bash
$ docker-compose -f docker-compose-prod.yml -p prod up -d
```

### 3. Migrate prod  :  
```bash
$ docker-compose -f docker-compose-prod.yml -p prod exec api_prod bin/api eval "Api.Release.migrate"
```

### 4. Init db prod: 
Generic command : docker exec -u postgresuser containername psql dbname postgresuser -f /container/path/file.sql
```bash
$ docker-compose -f docker-compose-prod.yml -p prod exec -u root db_prod psql db_prod root -f /docker-entrypoint-initdb.d/init.sql
```
<p>&nbsp;</p>

## <strong>Docker usage for dev</strong>

If you got : error sh: 1: vue-cli-service: not found
Run :  
```bash
$ rm -rf node_modules package-lock.json && npm install
```
in your local encironment

### 1. Build no cache dev:  
```bash
$ docker-compose -f docker-compose.yml -p dev build --no-cache
```

### 2. Up dev containers:  
```bash
$ docker-compose -f docker-compose.yml -p dev up -d
```

### 3. Migrate dev:  
```bash
$ docker-compose -f docker-compose.yml -p dev exec api_dev mix ecto.migrate
```
### 4. Init db dev: 
Generic command : docker exec -u postgresuser containername psql dbname postgresuser -f /container/path/file.sql
```bash
$ docker-compose -f docker-compose.yml -p dev exec -u postgres db_dev psql db_dev postgres -f /docker-entrypoint-initdb.d/init.sql
```




<p>&nbsp;</p>

## Contributing
Pull requests are welcome !

<p>&nbsp;</p>

## License
[MIT](https://choosealicense.com/licenses/mit/)
