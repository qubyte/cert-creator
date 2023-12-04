#!/bin/sh

cp cert.conf.template cert.conf

counter=1
days_valid=1000

while test $# -gt 0; do
    case "$1" in
        -d|--domain)
            shift

            if test $# -gt 0; then
                echo "DNS.$counter = $1" >> cert.conf
                counter=$((counter+1))

                if [ -z "$first_domain" ]; then
                    first_domain="$1"
                fi

                shift
            fi
            ;;
        -v|--valid)
            shift
            
            if test $# -gt 0; then
                days_valid="$1"
                shift
            fi
            ;;
                
        *)
            shift
            ;;
    esac
done

if [ -z "$first_domain" ]; then
    echo "No domain given."
    exit 1
fi

openssl genrsa 4096 > localCA.key
openssl req -x509 -sha256 -new -nodes -key localCA.key -days $days_valid -out localCA.pem -subj "/CN=$first_domain"
openssl genrsa 2048 > local.key
openssl req -new -key local.key -subj "/CN=$first_domain" > local.csr
openssl x509 -req -sha256 -days $days_valid -CA localCA.pem -CAkey localCA.key -CAcreateserial -in local.csr -extfile cert.conf -extensions domain_devlocal > local.pem

cp localCA.pem /out
cp local.key /out
cp local.pem /out
