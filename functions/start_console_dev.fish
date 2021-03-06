# see console-server/README.md
function start_console_dev
  set -gx DB_HOST (docker-machine ip default)
  set -gx DB_PASSWORD newcontext

  set -gx RMQ_PORT 5672
  set -gx RMQ_USER newcontext
  set -gx RMQ_PASSWORD newcontext

  docker rm -f database
  docker run -d \
             -e MYSQL_ROOT_PASSWORD=newcontext \
             -p 3306:3306 \
             --name database \
             mysql:5.5

  docker rm -f rabbitmq
  docker run -d \
             -e RABBITMQ_USER=newcontext \
             -e RABBITMQ_PASSWORD=newcontext \
             -p 15672:15672 \
             -p 5672:5672 \
             --name rabbitmq \
             forcemultiplier/rabbitmq

  echo 'Run `console-server/bin/setup` to populate the database'
end
