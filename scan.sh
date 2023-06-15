cat ip.txt | while read line    
do
	$(pwd)/nmap.sh $line
done
