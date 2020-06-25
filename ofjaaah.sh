#Create Ataide Junior - OFJAAAH

echo -e "\e[33mOF\e[32mJAAAH\e[31m Automation Recoon\n"
echo -e "\e[5mhttps://www.linkedin.com/in/atjunior/ \e[25mConnect :D "

#install dependenci
#GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/cmd/subfinder
#go get -u github.com/tomnomnom/assetfinder
#go get -u github.com/tomnomnom/hacks/ettu
#GO111MODULE=on go get -v github.com/projectdiscovery/naabu/cmd/naabu
#go get -u github.com/tomnomnom/httprobe
#go get github.com/tomnomnom/waybackurls
#GO111MODULE=on go get -u -v github.com/projectdiscovery/nuclei/cmd/nuclei
#git clone https://github.com/projectdiscovery/nuclei-templates.git
#go get -u github.com/cgboal/sonarsearch/crobat-client
#crobat-client --init
#git clone https://github.com/incogbyte/shosubgo.git


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

if [ ! -d naabu ]; then
    mkdir -p naabu
fi

if [ ! -d subhttp ]; then
    mkdir -p subhttp
fi

if [ ! -d amass ]; then
    mkdir -p amass
fi

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

if [ ! -d cert ]; then
    mkdir -p cert
fi 

if [ ! -d crobalt ]; then
    mkdir -p crobalt
fi 

#Delet files########################

rm -rf naabu/*.*
rm -rf subhttp/*.*
rm -rf amass/*.*
rm -rf full/*.*
rm -rf httprobe/*.*
#rm -rf ettu/*.*
rm -rf asset/*.*
#rm -rf nuclei/*.*
rm -rf shosubgo/*.*
rm -rf findomain/*.*
#rm -rf cert/*.*
rm -rf crobalt/*.*
####################################

getcro(){
crobat-client --all $1 >> crobalt/crob.txt
}

#getcert(){
#&> /dev/null curl -s "https://crt.sh/?q=$1&output=json" | jq '.[]["name_value"]' | sort -u | tr -d '"' >> cert/cert.txt
#}

getsho(){
&> /dev/null shosubgo -d $1 -s APY_KEY-SHODAN >> shosubgo/shosubgo.txt
}

#getamass(){
#&> /dev/null amass enum -d $1 -brute -active -o amass/amassdns.txt
#}

getfindomain(){
&> /dev/null /home/ofjaaah/PENTESTER/findomain-linux -t $1 -u findomain/findomain.txt
}

echo -e "\e[92mRecon running, please. Wait..\n"
getsubfinder(){ 
subfinder -d $1 -silent >> subhttp/saida.txt 
}

#getettu(){
#ettu --depth=2 $1 /home/ofjaaah/PENTESTER/SecLists/Discovery/DNS/bitquark-subdomains-top100K.txt >> ettu/ettu.txt
#}

getassetfinder(){
assetfinder --subs-only $1 >> asset/finder.txt

}
getcollect(){
cat shosubgo/shosubgo.txt subhttp/saida.txt asset/finder.txt findomain/findomain.txt cert/cert.txt crobalt/crob.txt | sort -u  >> full/fullenumerate.txt
}

gethtttprobe(){
cat full/fullenumerate.txt | httprobe  >> httprobe/urls.txt
}

#getwayback(){
#cat httprobe/urls.txt | waybackurls >> httprobe/wayback.txt
#}

getnaabu(){
&> /dev/null naabu -hL full/fullenumerate.txt -ports full -o naabu/naabucomplet.txt -silent
}

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
getcro $1
#getcert $1
getsho $1
#getamass $1
getfindomain $1
getsubfinder $1
#getettu $1
getassetfinder $1
getcollect $1
gethtttprobe $1
#getwayback $1
getnaabu $1
#getnuclei $1
