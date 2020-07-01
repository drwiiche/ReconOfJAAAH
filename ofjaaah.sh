└──╼ #cat ofjaaah.sh 
#Create Ataide Junior - OFJAAAH

echo -e "\e[33mOF\e[32mJAAAH\e[31m Automation Recoon\n"
echo -e "\e[5mhttps://www.linkedin.com/in/atjunior/ \e[25mConnect :D "

#install dependenci
#apt-get install jq
#go get -u github.com/cgboal/sonarsearch/crobat-client
#crobat-client --init
#cd modules && cp *.* /usr/bin/
#Create folders####################

#if [ ! -d nuclei ]; then
#    mkdir -p nuclei
#fi

#if [ ! -d nuclei/cve ]; then
#    mkdir -p nuclei/cve
#fi

#if [ ! -d nuclei/files ]; then
#   mkdir -p nuclei/files
#fi

#if [ ! -d nuclei/subtk ]; then
#   mkdir -p nuclei/subtk
#fi

#if [ ! -d nuclei/examples ]; then
#   mkdir -p nuclei/examples
#fi


if [ ! -d subhttp ]; then
    mkdir -p subhttp
fi

#if [ ! -d amass ]; then
#    mkdir -p amass
#fi

if [ ! -d full ]; then
    mkdir -p full
fi

if [ ! -d httprobe ]; then
    mkdir -p httprobe
fi

#if [ ! -d ettu ]; then
#    mkdir -p ettu
#fi

if [ ! -d asset ]; then
    mkdir -p asset
fi

if [ ! -d shosubgo ]; then
    mkdir -p shosubgo
fi

if [ ! -d findomain ]; then
    mkdir -p findomain
fi

if [ ! -d crobalt ]; then
    mkdir -p crobalt
fi 

if [ ! -d masscan ]; then
    mkdir -p masscan
fi

if [ ! -d asn ]; then
    mkdir asn
fi

if [ ! -d cert ]; then
    mkdir cert 
fi

#Delet files########################

rm -rf subhttp/*.*
#rm -rf amass/*.*
rm -rf full/*.*
rm -rf httprobe/*.*
#rm -rf ettu/*.*
rm -rf asset/*.*
#rm -rf nuclei/*.*
rm -rf shosubgo/*.*
rm -rf findomain/*.*
rm -rf crobalt/*.*
rm -rf masscan/*.*
rm -rf cert/*.*
rm -rf asn/*.*
####################################

getcert(){
curl -s "https://crt.sh/?q=$1&output=json" | jq -r '.[]["name_value"]' | sed 's#\*\.##g; s#www\.##g' | grep "\." | unfurl domains | sort -u >> cert/cert.txt
}

getasn(){
bash asn.sh $1 | egrep '([0-9]{1,3}\.){3}[0-9]{1,3}.[[:digit:]]{1,}' -o >> asn/asn.txt
}

getcro(){
crobat-client --all $1 >> crobalt/crob.txt
}

getsho(){
&> /dev/null shosubgo -d $1 -s APIKEYSHODAN >> shosubgo/shosubgo.txt
}

#getamass(){
#&> /dev/null amass enum -d $1 -brute -active -o amass/amassdns.txt
#}

getfindomain(){
&> /dev/null /home/ofjaaah/PENTESTER/findomain-linux -t $1 -u findomain/findomain.txt
}

echo -e "\e[92mRecon running, please. Wait..\n"
getsubfinder(){
subfinder -d $1 -silent >> subhttp/subfin.txt 
}

#getettu(){
#ettu --depth=2 $1 /home/ofjaaah/PENTESTER/SecLists/Discovery/DNS/bitquark-subdomains-top100K.txt >> ettu/ettu.txt
#}

getassetfinder(){
assetfinder --subs-only $1 >> asset/finder.txt

}
getcollect(){
&> /dev/null cat cert/cert.txt shosubgo/shosubgo.txt subhttp/subfin.txt asset/finder.txt findomain/findomain.txt crobalt/crob.txt >> full/fullenumerate.txt
}

#Recon 2 filter
getfilter(){
&> /dev/null subfinder -dL full/fullenumerate.txt -silent -o full/filter.txt
}

gethtttprobe(){
&> /dev/null cat full/fullfilter.txt | httprobe  >> httprobe/urls.txt
}

getmasscan(){
&> /dev/null masscan -iL asn/asn.txt -p80,443,8000,8080,8443,4444,10001,10000,3306,21,22,8181 --rate 1000000 --source-port 60000 --wait 40 >> masscan/result.txt
}

#Recon - Wordlist
#getettu(){ ettu
#cat /home/ofjaaah/PENTESTER/SecLists/Discovery/DNS/bitquark_20160227_subdomains_popular_1000000.txt | ettu --depth=2 $1
#}

#getnuclei(){
#&> /dev/null nuclei -l full/fullenumerate.txt -t /home/ofjaaah/PENTESTER/nuclei-templates/cves/ -o nuclei/cve/cve.txt
#&> /dev/null nuclei -l full/fullenumerate.txt -t /home/ofjaaah/PENTESTER/nuclei-templates/files/ -o nuclei/files/files.txt
#&> /dev/null nuclei -l full/fullenumerate.txt -t /home/ofjaaah/PENTESTER/nuclei-templates/subdomain-takeover/ -o nuclei/subtk/subtk.txt
#&> /dev/null nuclei -l full/fullenumerate.txt -t /home/ofjaaah/PENTESTER/nuclei-templates/examples/ -o nuclei/example/exp.txt
#}

#run
getcert $1
getasn $1
getcro $1
getsho $1
#getamass $1
getfindomain $1
getsubfinder $1
#getettu $1
getassetfinder $1
getcollect $1
getfilter $1
gethtttprobe $1
getmasscan $1
#getnuclei $1
