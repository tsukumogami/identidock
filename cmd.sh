#!/bin/bash

# exit immediately if a command exits with a non-zero status
set -e

if [ "$ENV" = 'DEV' ]; then
    echo "Running development server"
    exec python "identidock.py"
elif [ "$ENV" = 'UNIT' ]; then
    echo "Running unit tests"
    exec python "tests.py"
else
    echo "Running production server"
    # uWSGI запускает http-сервер и инициализирует приложение из /app/identidock.py
    # также инициализируется сервер наблюдения за состоянием
        exec uwsgi --http 0.0.0.0:$(echo $P_APP) --wsgi-file /app/identidock.py --callable app --stats 0.0.0.0:$(echo $P_STATS) --stats-http
fi