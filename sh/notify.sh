#!/bin/sh

while [[ $# > 1 ]]
do
  key="$1"

  case $key in
      -r|--register)
      KEY="$2"
      shift
      ;;
      -t|--text)
      TEXT="$2"
      shift
      ;;
      *)
      ;;
  esac

  shift
done

if [ -n "${KEY}" ]
then
  # Save token to ~/.notifyreg
  echo "${KEY}" > ~/.notifyreg
else
  KEY=`cat ~/.notifyreg`
  curl -G \
  "https://appnotify.herokuapp.com/notify" \
  --data-urlencode "to=${KEY}" \
  --data-urlencode "text=${TEXT}" \
  > /dev/null

  echo "[notify] Successfully sent notification."
fi
