# BigData_tech
Hands on Hadoop

## Hadoop Ecosystem Intro
 
* This is an open source software platform developed by Yahoo for distributed stoage and processing of very large datasets on computer clusters.  
* GFS + MapReduce with horizontal scaling (Adding more nodes)

Building blocks

1) HDFS - Hadoop distributed file system  - Distributed data storage
2) YARN - Yet another resournce negotiator - Managed distributed processing
3) MapReduce - Mappers transform data in prallel across cluster and reducers aggregate it

4) Pig - High level programming api that allows you to write sql like scripts to chain queries and get complex answers to run on mapreduce instead of python or java code. 
5) Hive - Looks like a SQL database  


6) Ambari - Lets you visualize and sits on top of all these


![alt text](https://github.com/snknitin/BigData_tech/blob/master/static/coresys.PNG)

- Mesos is an alternative to Yarn  
- Spark is at the same level of MapReduce and sits over yarn or mesos, to run queries on the data.It is extermerly fast.Spark scripts  like MR require coding in either Python, Java or Scala(prefered). It can do ML, handle streaming data, handle SQL queries 
- Tez is used with hive to accelerate it and it used DAG. Similar to Spark  
- Hbase is a NoSQL db that exposes data on cluster to other systems  
- Apache Storm processing streaming data in real time  
- OOzie is a way of scheduling jobs on clusters run on a schedule  
- Zookeeper co-ordinates and keeps track of which nodes are up or down, which is master etc  
- Sqoop deals with data ingestion(getting data into the clusters and HDFS from external sources). It is a connector between hadoop and lecacy databases  
- Flume is a way of reliably transporting weblogs at a very large scale  
- Kafka can collect data of any sort from a cluster and broadcast it into hadoop  

## External Data Storage

* MySQL
* Cassandra
* mongoDB



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
