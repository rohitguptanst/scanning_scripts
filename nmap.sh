#!/bin/bash

url=$1
echo  "starting for $url \n"
mkdir $url
cd $url
nmap -p- -v $url --max-retries 0 > openports.txt
echo  "openports_done \n"
nmap -sV --script=vulners.nse $url | tee Vulnerabilities.txt
echo "vulners_done\n"
nmap -sV --script ssl-enum-ciphers -p 443 $url > Ciphers.txt
echo " ciphers_done\n"
nmap --script ssl-dh-params $url > DiffieHellman.txt
echo "ssh-dh-params_done\n"
nmap -p 80 --script dns-brute.nse $url > DNS-Brute.txt
echo "dns-brute_done\n"
nmap -p 443 --script ssl-heartbleed $url > Heartbleed.txt
echo "heartbleed_done\n"
nmap --script http-enum $url > HTTP-ENUM.txt
echo "http-enum_done\n"
nmap --script http-title -sV -p 80 $url > HTTP-TITLE.txt
echo "http_title_done\n"
nmap -sV -Pn $url > Nmap.txt
echo "normal_nmap_done\n"
nmap -Pn --script http-slowloris-check $url > Slowris.txt
echo "http-slowloris_done\n"
nmap -sV --version-light --script ssl-poodle -p 443 $url > Poodle.txt
echo "ssl-poodle_done\n"
