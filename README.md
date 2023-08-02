# Docker Database Manager (BETA)

### What is this?

This repo, is a simple manager of containers docker that run database images. 

### Avaiable databases:
* MongoDB
* PostgreSQL

### Usage 

* Create a docker container with:
  * PostgreSQL: ``./database.sh --create postgres``
  * MongoDB: ``./database.sh --create mongo``
* Delete a docker-compose.yaml: ``./database.sh --remove docker-compose``
* Delete a container docker: ``./database.sh --remove container <container_id>``
* Run the database: ``./database.sh -run``

### Tags

* ``-rm`` or ``--remove``: Remove something (obviously)
* ``-c`` or ``--create``: Create something (obviously too)
* ``-run``: Start something (...)

