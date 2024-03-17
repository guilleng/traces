#!/usr/bin/env sh

# Checks
# ------

type curl >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "curl not found." >&2
  exit 1
fi

type jq >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "jq JSON parser not found." >&2
  exit 1
fi

type traceroute >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "traceroute not found." >&2
  exit 1
fi

if [ "$(id -u)" -ne 0 ]; then 
  echo "The traceroute method runs only as root." >&2; 
  exit 1
fi

if [ -z "${1}" ]; then 
  echo "Please provide as argument a valid hostname or IPv4 address." >&2; 
  exit 1; 
fi


# Data Fetching
# -------------

JSON_DATA=$(mktemp)
TRACE_DETAILS=$(mktemp)

if ping -q -w5 -c1 "${1}" >/dev/null 2>&1; then
	for ADDR in $(traceroute -n -q1 -I "${1}" 2>/dev/null | awk '{print $2}' | grep '^[0-9]'); do
    curl -s http://ipinfo.io/"${ADDR}" >> "${JSON_DATA}"
  done
else
  echo "Can't ping host '${1}', abort." >&2
  rm "${TRACE_DETAILS}" "${JSON_DATA}"
  exit 1
fi


# Output Table Generation
# -----------------------

printf "\tIP\tLatitude/Longitude\tCity / Autonomous System Number / Company\n"
printf "%s\n" "-----------------------------------------------------------------------------------------------------------------------"
cat "${JSON_DATA}" | jq 'if has("bogon") then "\(.ip) Bogon" else "\(.ip) \(.loc) \(.city), \(.region) \(.country) - \(.org // "?")" end' \
  | sed 's/"//g;' \
  | awk '{printf "%s\t%s\t", $1, $2; for (i=3; i<=NF; i++) {printf "%s ", $i}; printf "\n"}' \
  | cut -c -111 >"${TRACE_DETAILS}"
cat "${TRACE_DETAILS}"


# Static Map Generation
# ---------------------

COORDINATES=$(cat "${TRACE_DETAILS}" | awk '{print $2}' | grep '[0-9]' | uniq | sed 's/,/ /g' | awk '{print $2, $1}')

set -- ${COORDINATES}
printf "\n%s" "https://maps.geoapify.com/v1/staticmap?style=maptiler-3d&width=1920&height=1080&center=lonlat:0,20&zoom=1.9&geometry=polyline:${1},${2}"
while [ -n "${3}" ]; do
  shift 2
  printf "%s" ",${1},${2}"
done
printf "%s" ";linewidth:5;linecolor:%23ff6600;lineopacity:1;linewidth:1"

set -- ${COORDINATES}
N=1
printf "%s" "&marker=lonlat:${1},${2};color:%23ff0000;size:small;text:${N}"
while [ -n "${3}" ]; do
  shift 2
  N=$(( N+1 ))
  printf "%s" "|lonlat:${1},${2};color:%23ff0000;size:small;text:${N}"
done

printf "%s\n" "&scaleFactor=2&apiKey=d548c5ed24604be6a9dd0d989631f783"
rm "${TRACE_DETAILS}" "${JSON_DATA}"
