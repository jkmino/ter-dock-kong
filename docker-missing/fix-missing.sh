#!/bin/sh
docker container run -it -v $(pwd)/missing:/usr/local/bin/missing bennu/jobs:missing
