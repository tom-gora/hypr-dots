# serve static php
function php-server() {
local port
  for ((port=9000; port<=65535; port++)); do
    netstat -tln | grep -qE "\b${port}\b"
      if [ $? -ne 0 ]; then
        php -S localhost:$port &
        sleep 1
        xdg-open http://localhost:$port &
        return 0
      fi
  done

  echo "No available ports in the range 9000-65535."
  return 1
}

function cat-tail() {
if [ $# -ne 2 ]; then
  echo "Usage: cat-tail <file> <lines-from-end>\nor\ncat-tail <lines-from-end> <file>"
  exit 1
fi
local file
local lines
if [ -f "$1" ]; then
  file="$1"
  lines="$2"
elif [ -f "$2" ]; then
file="$2"
lines="$1"
 else
echo "File not found."
exit 1
fi


if ! [[ $lines =~ ^[0-9]+$ ]] || [ $lines -lt 1 ]; then
  echo "Lines must be a positive number."
  exit 1
fi

bat $file --line-range $(expr $(wc -l $file | cut -d" " -f 1) - $(expr $lines - 1)): --wrap character
}


function cat-head() {
if [ $# -ne 2 ]; then
  echo "Usage: cat-tail <file> <lines-from-end>\nor\ncat-tail <lines-from-end> <file>"
  exit 1
fi
local file
local lines
if [ -f "$1" ]; then
  file="$1"
  lines="$2"
elif [ -f "$2" ]; then
file="$2"
lines="$1"
 else
echo "File not found."
exit 1
fi


if ! [[ $lines =~ ^[0-9]+$ ]] || [ $lines -lt 1 ]; then
  echo "Lines must be a positive number."
  exit 1
fi

bat $file --line-range :$lines --wrap character
}
