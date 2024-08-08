#1/bin/sh

echo "$(lsb_release -i | awk '{ print $3 }') $(lsb_release -c | awk '{ print $2 }')"
