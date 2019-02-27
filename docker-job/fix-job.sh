#!/bin/sh
docker container run -v $(pwd)/entrynew.sh:/opt/jobs/sh/entrypoint.sh -v $(pwd)/message:/opt/jobs/sh/message --rm bennu/jobs:sh
