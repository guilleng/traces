Traces
------

A script that interacts with [ipinfo.io](https://ipinfo.io) and
[Geoapify](https://apidocs.geoapify.com/) to retrieve IP data and generate
static maps for traceroutes.

<p align="center">
  <img src="https://github.com/guilleng/traces/blob/master/map.webp?raw=true" alt="Traceroute"/>
</p>


### Usage

```sh
# trace 128.171.235.62
        IP      Latitude/Longitude      City / Autonomous System Number / Company
----------------------------------------------------------------------------------------
244.5.0.175     Bogon   
240.3.12.65     Bogon   
242.7.27.1      Bogon   
240.0.236.3     Bogon   
242.2.213.71    Bogon   
100.100.2.2     Bogon   
99.82.179.33    38.9687,-77.3411        Reston, Virginia US - ? 
163.253.1.128   38.9687,-77.3411        Reston, Virginia US - AS11537 Internet2 
163.253.1.123   41.4995,-81.6954        Cleveland, Ohio US - AS11537 Internet2 
163.253.1.211   41.8500,-87.6500        Chicago, Illinois US - AS11537 Internet2 
163.253.1.206   41.8500,-87.6500        Chicago, Illinois US - AS11537 Internet2 
163.253.2.29    39.0997,-94.5786        Kansas City, Missouri US - AS11537 Internet2 
163.253.1.250   39.7392,-104.9847       Denver, Colorado US - AS11537 Internet2 
163.253.1.169   40.7608,-111.8911       Salt Lake City, Utah US - AS11537 Internet2 
163.253.1.114   34.0522,-118.2437       Los Angeles, California US - AS11537 Internet2 
205.166.205.12  21.3069,-157.8583       Honolulu, Hawaii US - AS6360 University of Hawaii 
205.166.205.33  21.3069,-157.8583       Honolulu, Hawaii US - AS6360 University of Hawaii 
128.171.235.62  21.3069,-157.8583       Honolulu, Hawaii US - AS6360 University of Hawaii 

https://maps.geoapify.com/v1/staticmap?style=maptiler-3d&width=1920&height=1080&center=lonlat:0,20&zoom=1.9&geometry=polyline:-77.3411,38.9687,-81.6954,41.4995,-87.6500,41.8500,-94.5786,39.0997,-104.9847,39.7392,-111.8911,40.7608,-118.2437,34.0522,-157.8583,21.3069;linewidth:5;linecolor:%23ff6600;lineopacity:1;linewidth:1&marker=lonlat:-77.3411,38.9687;color:%23ff0000;size:small;text:1|lonlat:-81.6954,41.4995;color:%23ff0000;size:small;text:2|lonlat:-87.6500,41.8500;color:%23ff0000;size:small;text:3|lonlat:-94.5786,39.0997;color:%23ff0000;size:small;text:4|lonlat:-104.9847,39.7392;color:%23ff0000;size:small;text:5|lonlat:-111.8911,40.7608;color:%23ff0000;size:small;text:6|lonlat:-118.2437,34.0522;color:%23ff0000;size:small;text:7|lonlat:-157.8583,21.3069;color:%23ff0000;size:small;text:8&scaleFactor=2&&apiKey=d548c5ed24604be6a9dd0d989631f783
```




### Installation

Requires the `traceroute`, `curl` and `jq` packages.

Clone or copy.  Set executable permissions.  Make a symlink to the script. 

```bash
git clone https://github.com/guilleng/traces
chmod +x traces/script.sh
ln -s "$(pwd)/sprunges/script.sh" ~/.local/bin/traces
```

Or [download as zip](https://github.com/guilleng/sprunges/zipball/master).
