#!/bin/sh

# Generate _data/tools.csv that is used by Jekyll to generate pages.
# Format: <name>\t<version>\t<url>\t<description>

export LC_ALL=C

SITE="blackarch.org"
REPO="blackarch"
ARCH="x86_64"
OUT="_data/tools.csv"

# Remove previous file entry except the mirrors file
find _data -name 'tools.csv' -type f -exec rm -f {} +

make_tmp() {
    tmp=$(mktemp -d /tmp/blackarch.XXXXXXXXXXX)
}

get_db() {
    curl "https://$SITE/blackarch/$REPO/os/$ARCH/$REPO.db.tar.gz" |
	tar xz -C "$tmp"
}

parse_db() {
    mkdir -p "$(dirname file)"
    echo "group,name,vers,desc,url,build" >> "$OUT"
    for d in "$tmp"/*
    do
	# Name
        name="$(grep --no-group-separator -A2 '^%NAME%$' "${d}"/desc |
        sed -e 's/[0-9]\+://' -e 's/-[0-9]\+//' | grep -v '^%NAME%$')"

	# Version
        vers="$(grep --no-group-separator -A2 '^%VERSION%$' "${d}"/desc |
        sed -e 's/[0-9]\+://' -e 's/-[0-9]\+//' | grep -v '^%VERSION%$')"

	# Description
        desc="$(grep --no-group-separator -A2 '^%DESC%$' "${d}"/desc |
        sed -e 's/[0-9]\+://' -e 's/-[0-9]\+//' | grep -v '^%DESC%$')"
    # Build
        build="$(grep --no-group-separator -A2 '^%BUILDDATE%$' "${d}"/desc |
        sed -e 's/[0-9]\+://' -e 's/-[0-9]\+//' | grep -v '^%BUILDDATE%$')"
	# Category
	# Add exception for the following packages
	case "${name}" in
	    "truecrack"|"cudahashcat"|"cryptohazemultiforcer")
		group="blackarch-cracker"
		;;
	    "vmcloak")
		group="blackarch-malware"
		;;
	    *)
	    	# All the other packages (add '0,/blackarch/s///' for remove first occurrence only
		group="$(grep --no-group-separator -A2 '^%GROUPS%$' "${d}"/desc |
		sed -e 's/[0-9]\+://' -e 's/-[0-9]\+//' -e '0,/blackarch/s///' | grep -v '^%GROUPS%$' |
		tr -s '\n' ' ')"
	esac
	
	# Website url
    url="$(grep --no-group-separator -A2 '^%URL%$' "${d}"/desc |
      sed -e 's/[0-9]\+://' -e 's/-[0-9]\+//' | grep -v '^%URL%$')"

	fgroup=$(echo "$group" | sed -e 's/blackarch-//g' -e 's/ //g' -e "s/'//g")
	noquotedesc=$(echo "$desc" | sed -e "s#\"#\'#g")
    dqt='"'
    if [ "$fgroup" ]; then
        if [ "$url" ]; then
	        echo "$fgroup,$name,$vers,${dqt}$noquotedesc${dqt},${dqt}$url${dqt},$build" >> "$OUT"
        else
            echo "$fgroup,$name,$vers,${dqt}$noquotedesc${dqt},,$build" >> "$OUT"
	    fi
    fi
  done
}

split() {
    sed -i 's/\t/,/g' "$OUT"
}

main() {

    rm -f "$OUT"
    make_tmp
    get_db
    parse_db
    split
}

main "$@"
