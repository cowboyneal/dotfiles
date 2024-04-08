#!/usr/bin/env bash

all_mails=$(grep '^From ' /var/mail/$USER | wc -l)
old_mails=$(($(pcre2grep -M '^Status: RO\nContent-Length:.*\nLines:.*' \
    /var/mail/$USER | wc -l)/3))
new_mails=$((all_mails-old_mails))

printf "%s" $all_mails

if [ $new_mails -gt 0 ]; then
    printf " | %s new" $new_mails
fi
