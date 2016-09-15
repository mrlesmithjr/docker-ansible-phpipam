docker-phpipam
--------------

Builds [Docker] image to run [phpIPAM] container provisioned using [Ansible].  
Based on Alpine Linux.  

Consuming
---------
```
docker run -d --name db \
  -e MYSQL_ROOT_PASSWORD=phpipam \
  -e MYSQL_DATABASE=phpipam \
  -e MYSQL_USER=phpipam \
  -e MYSQL_PASSWORD=phpipam \
  -v db:/var/lib/mysql \
  mrlesmithjr/mysql
```
```
docker run -d --name web \
  -e APACHE2_ENABLE_PHP="true" \
  -e PHPIPAM_DB_HOST="db" \
  -e PHPIPAM_DB_NAME="phpipam" \
  -e PHPIPAM_DB_PASS="phpipam" \
  -e PHPIPAM_DB_USER="phpipam" \
  -p 8000:80 \
  --link db:db \
  mrlesmithjr/phpipam
```

Spin up [phpIPAM] environment using the included `docker-compose.yml`.  

```
version: '2'
services:
  db:
    image: "mrlesmithjr/mysql:latest"
    volumes:
      - "db:/var/lib/mysql"
    restart: "always"
    environment:
      MYSQL_ROOT_PASSWORD: "phpipam"
      MYSQL_DATABASE: "phpipam"
      MYSQL_USER: "phpipam"
      MYSQL_PASSWORD: "phpipam"

  web:
    depends_on:
      - db
    image: "mrlesmithjr/phpipam:latest"
    links:
      - "db"
    ports:
      - "8000:80"
    restart: "always"
    environment:
      APACHE2_ENABLE_PHP: "true"
      PHPIPAM_DB_HOST: "db"
      PHPIPAM_DB_NAME: "phpipam"
      PHPIPAM_DB_PASS: "phpipam"
      PHPIPAM_DB_USER: "phpipam"
volumes:
  db:
```

Spin up the environment with `docker-compose up -d`

Once complete if you run `docker-compose ps` you should see similar to below:

```
Name                         Command               State               Ports
---------------------------------------------------------------------------------------------------
dockeransiblephpipam_db_1    /docker-entrypoint.sh /usr ...   Up      3306/tcp
dockeransiblephpipam_web_1   /docker-entrypoint.sh            Up      443/tcp, 0.0.0.0:8000->80/tcp
```
And you are now good to go to begin using [phpIPAM].

http://IPorHostname:8000

`admin\ipamadmin`

Notes
-----

If you spin this up using `docker-compose` then you will have a persistent data
volume that gets created to ensure that your data remains. The data volume is
created as a name so it is easier to find and will always be mapped to the same
volume. By default this will be named as the project name_db. So for example:
`dockeransiblephpipam_db`.
You can view/inspect this volume by:
```
docker volume inspect dockeransiblephpipam_db
```
```
[
    {
        "Name": "dockeransiblephpipam_db",
        "Driver": "local",
        "Mountpoint": "/var/lib/docker/volumes/dockeransiblephpipam_db/_data",
        "Labels": null,
        "Scope": "local"
    }
]
```

License
-------

BSD

Author Information
------------------

Larry Smith Jr.
- [@mrlesmithjr]
- [everythingshouldbevirtual.com]
- [mrlesmithjr@gmail.com]


[Ansible]: <https://www.ansible.com/>
[Docker]: <https://www.docker.com>
[phpIPAM]: <http://phpipam.net/>
[@mrlesmithjr]: <https://twitter.com/mrlesmithjr>
[everythingshouldbevirtual.com]: <http://everythingshouldbevirtual.com>
[mrlesmithjr@gmail.com]: <mailto:mrlesmithjr@gmail.com>
