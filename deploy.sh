#!/usr/bin/env bash

# R
sudo yum -y install R
sudo yum -y install curl-devel
sudo yum -y install libpng-devel
sudo yum -y install screen

sudo mkdir /team6
sudo mount -t nfs 10.1.92.154:xdata-team6 /team6

sudo R CMD javareconf
sudo su - -c "R -e \"install.packages('rJava', repos='http://www.rforge.net/')\""
sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.rstudio.com/')\""
sudo su - -c "R -e \"install.packages('shiny', repos='http://cran.rstudio.com/')\""
sudo -E R -e "options(unzip = 'unzip', repos = 'http://cran.rstudio.com/'); library(devtools); install_github('tesseradata/datadr')"
sudo -E R -e "options(unzip = 'unzip', repos = 'http://cran.rstudio.com/'); library(devtools); install_github('tesseradata/trelliscope')"
sudo -E R -e "options(unzip = 'unzip', repos = 'http://cran.rstudio.com/'); library(devtools); install_github('hafen/nxcore')"

export PROTO_BUF_VERSION=2.5.0
wget https://protobuf.googlecode.com/files/protobuf-$PROTO_BUF_VERSION.tar.bz2
tar jxvf protobuf-$PROTO_BUF_VERSION.tar.bz2
cd protobuf-$PROTO_BUF_VERSION
./configure && make -j4
sudo make install
cd ..

export RHIPE_VERSION=0.75.1.3_hadoop-2

wget http://ml.stat.purdue.edu/rhipebin/Rhipe_$RHIPE_VERSION.tar.gz

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
sudo chmod 777 /usr/lib64/R/library
sudo chmod -R 777 /usr/share/
R CMD INSTALL Rhipe_$RHIPE_VERSION.tar.gz

echo export 'LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' | tee -a /home/vagrant/.bashrc
echo export 'PKG_CONFIG_PATH=/usr/local/lib/pkgconfig' | tee -a /home/vagrant/.bashrc
echo export 'JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.75.x86_64/jre' | tee -a ~/.bashrc
echo export 'HADOOP_CONF_DIR=/vagrant/hadoop' | tee -a /home/vagrant/.bashrc
echo export 'HADOOP_HOME=/usr/lib/hadoop' | tee -a /home/vagrant/.bashrc
echo export 'HADOOP_BIN=/usr/bin/hadoop:/usr/lib/hadoop/lib' | tee -a /home/vagrant/.bashrc
echo export "HADOOP_LIBS=`hadoop classpath | tr -d '*'`" | tee -a /home/vagrant/.bashrc
