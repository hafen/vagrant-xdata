# vagrant-xdata

DARPA XData Vagrant VM

Please make sure that vbguest is installed (https://github.com/dotless-de/vagrant-vbguest/).

```
vagrant plugin install vagrant-vbguest
```

It helps keep the VirtuaalBoxGuestAdditions up to date.

Once you `vagrant up`, you can install whatever R packages you need.  Then you need to create an archive of R and all the packages to be sent to all the nodes on the cluster.  You can do this with the following:

```s
setwd("~/")
hdfs.setwd("/user/__username__")
bashRhipeArchive("rhipe")
```

After it completes, it will tell you what commands to use to initialize RHIPE.
