# build docker container

```
docker build . -t socialhackday
```

# run server

```
docker-compose up server
```

access to [http://localhost:4567](http://localhost:4567)

# run build

```
docker-compose run build
```

You will find compiled HTML files in `./build` directory.
