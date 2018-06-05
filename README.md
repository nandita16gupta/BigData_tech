# BigData_tech
Hand on Hadoop


# Install VirtualBox

Download from https://www.virtualbox.org/wiki/Downloads

# Get an Image from archive

Prefer version 2.5 because the latest ones take a lot of time to boot and Import this into the virtual box. It may take a few minutes as it is 11GB in size

https://hortonworks.com/downloads/

Login to the virtual machine at http://127.0.0.1:8888/  

uname: maria_dev  
pwd: maria_dev  

This takes you to the Dashboard

## Dataset 1

MovieLens 100K Dataset

http://files.grouplens.org/datasets/movielens/ml-100k.zip


* Now that we downloaded into our Hadoop cluster we use Hive to actually execute SQL queries on top of that data, even though it's not really being stored in the relational database and could be a distributed manner across an entire cluster.
* u.data file represents our tab limited data: user_id\t movie_id\t rating\t timestamp
* u.item file has information about the data rows. Mappings from movie id to movie name, release date and genre

Load using the Hive View tool in Ambari-Sandbox, go to Upload Table and select u.data  
You can use the cvs importer even though it is tab separated  by selecting the options  
After giving it column names, uploading it will create a view within Hive that is sitting on our Hadoop instance  
Now upload the u.item ffile limited by | symbol

- Use SQL queriies on these databases and visualize them with the inbuilt tool
