#!/bin/sh

# Generate _data/packages.csv that is used by Jekyll to generate pages.
# Format: <name>\t<version>\t<url>\t<description>

export LC_ALL=C

SITE="blackarch.org"
REPO="blackarch"
ARCH="x86_64"
OUT="_data/packages.csv"
OUT_TORRENTS="_data/torrents.csv"
# Remove previous file entry except the mirrors file
find _data -name 'packages.csv' -type f -exec rm -f {} +

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

	egroup=$(echo "$group" | sed -e 's/blackarch-//g' -e 's/^[ \t]*//g' -e 's/[ \t]*$//' -e 's/ /;/g' -e "s/'//g")
    fgroup=$(echo "$egroup" | sed -e 's/-malware/Malware/g')
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

parse_torrents() {
    rm -f "$OUT_TORRENTS"
    #wget -r -nH --cut-dirs=2 --no-parent --reject="robots.txt" --accept="*.torrent" http://blackarch.pi3rrot.net/torrent/ -P ./torrents
    #rm ./torrents/*.tmp
    echo "file,kind,date,type,architecture"  >> "$OUT_TORRENTS"
    for d in "./torrents"/*
    do
        
        TORRENT=$(basename $d)
        echo $TORRENT | while IFS=. read PART1 PART2 PART3 PART4
        do
            if [[ $PART1 == *"live"* ]]
            then
                KIND="live"
            elif [[ $PART1 == *"netinst"* ]]
            then
                KIND="netinst"
            else
                KIND=""
            fi
            if [[ $PART3 == *"x86_64"* ]]; then
                ARCH=",amd64"
            else
                ARCH=""
            fi
            YEAR=${PART1: -4}
            MONTH=${PART2}
            DAY=${PART3:0:2}
            TYPE=${PART4:0:3}
            echo "$TORRENT,$KIND,$YEAR-$MONTH-$DAY,$TYPE$ARCH" >> "$OUT_TORRENTS"
        done
    done
}

main() {

    rm -f "$OUT"
    make_tmp
    get_db
    parse_db
    split
    parse_torrents

}

main "$@"
