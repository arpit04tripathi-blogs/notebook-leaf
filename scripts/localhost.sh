echo =========================================================
echo Running $0 with $# arguments
echo [processID] $$
echo [arguments] $@
echo =========================================================

case $1 in
  --start)
    echo docker compose up
    docker compose -f ./docker/docker-compose.yml up server -d
    cmd=$( open -a "Google Chrome" http://localhost:9999/notebook-leaf/ )
    echo opening chrome $cmd
    ;;
  --stop)
    echo "running docker compose down"
    docker compose -f ./docker/docker-compose.yml down
    ;;
  *)
    echo use either --start or --stop
    ;;
esac

echo
