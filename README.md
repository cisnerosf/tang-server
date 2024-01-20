# docker-tang

Docker image for running a [tang server](https://github.com/latchset/tang)

## Usage

### Docker

Running the tang daemon (`tangd`)

~~~bash
docker run -p 8000:8000 -v tang-data:/data kylekingcdn/tang
# or
docker run -p 8000:8000 -v tang-data:/data kylekingcdn/tang daemon
~~~

Running `tangd-keygen`

~~~bash
# note: the standard jwk argument is pre-populated
docker run -p 8000:8000 -v tang-data:/data kylekingcdn/tang keygen
~~~

Running `tangd-rotate-keys`

~~~bash
# note: the jwk directory option is pre-populated
docker run -p 8000:8000 -v tang-data:/data kylekingcdn/tang rotate-keys
~~~

Running  `tang-show-keys`

~~~bash
# note: the standard port argument is pre-populated
docker run -p 8000:8000 -v tang-data:/data kylekingcdn/tang show-keys
~~~

### Docker Compose

Sample `docker-compose.yml`

~~~yml
version: "3.8"
name: tang

services:
  tang:
    image: docker.io/kylekingcdn/tang:14
    restart: always
    networks:
      tang:
    ports:
      - 8000:8000/tcp
    volumes:
      - ./tangdb:/data
    environment:
      PUID: 1000 # optional, defaults to 1000
      PGID: 1000 # optional, defaults to 1000
      TANG_DB: /data # optional, defaults to /data
      TANG_PORT: 8000 # optional, defaults to port 8000

networks:
  tang:
~~~

Running `tangd-keygen`

~~~bash
# note: the standard jwk argument is pre-populated
docker compose exec tang keygen
~~~

Running `tangd-rotate-keys`

~~~bash
# note: the jwk directory option is pre-populated
docker compose exec tang rotate-keys
~~~

Running  `tang-show-keys`

~~~bash
# note: the standard port argument is pre-populated
docker compose exec tang show-keys
~~~

## Environment Variables

| Option      | Default | Description                                               |
|------------:|:--------|:----------------------------------------------------------|
| `PUID`      | `1000`  | The user ID used for running `tangd` (or other commands)  |
| `PGID`      | `1000`  | The group ID used for running `tangd` (or other commands) |
| `TAND_DB`   | `/data` | The tang db directory used within the container           |
| `TANG_PORT` | `8000`  | The port used by tang within the container                |
