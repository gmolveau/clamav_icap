# ClamAV with ICAP server

## Getting started

### Build

```bash
docker build -t clamav_icap:latest .
```

### Run

```bash
docker run --rm -d --name clamav_icap -p 1344:1344 clamav_icap:latest
# or
docker-compose up --build -d
```

### Client

use an ICAP client to contact the server : `localhost:1344` with the endpoint `srv_clamav`
