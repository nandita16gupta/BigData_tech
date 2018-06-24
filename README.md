# BigData_tech
Hands on Hadoop

[Tutorial Resources](http://sundog-education.com/hadoop-materials/)

## Hadoop Ecosystem Intro
 
* This is an open source software platform developed by Yahoo for distributed stoage and processing of very large datasets on computer clusters.  
* GFS + MapReduce with horizontal scaling (Adding more nodes)

Building blocks

1) **HDFS** - Hadoop distributed file system  - Distributed data storage
2) **YARN** - Yet another resournce negotiator - Managed distributed processing
3) **MapReduce** - Mappers transform data in prallel across cluster and reducers aggregate it

4) **Pig** - High level programming api that allows you to write sql like scripts to chain queries and get complex answers to run on mapreduce instead of python or java code. 
5) **Hive** - Looks like a SQL database  


6) **Ambari** - Lets you visualize and sits on top of all these


![alt text](https://github.com/snknitin/BigData_tech/blob/master/static/coresys.PNG)

- **Mesos** is an alternative to Yarn  
- **Spark** is at the same level of MapReduce and sits over yarn or mesos, to run queries on the data.It is extermerly fast.Spark scripts  like MR require coding in either Python, Java or Scala(prefered). It can do ML, handle streaming data, handle SQL queries 
- **Tez** is used with hive to accelerate it and it used DAG. Similar to Spark  
- **Hbase** is a NoSQL db that exposes data on cluster to other systems  
- **Apache Storm** processing streaming data in real time  
- **OOzie** is a way of scheduling jobs on clusters run on a schedule  
- **Zookeeper** co-ordinates and keeps track of which nodes are up or down, which is master etc  
- **Sqoop** deals with data ingestion(getting data into the clusters and HDFS from external sources). It is a connector between hadoop and lecacy databases  
- **Flume** is a way of reliably transporting weblogs at a very large scale  
- **Kafka** can collect data of any sort from a cluster and broadcast it into hadoop  

## External Data Storage

* MySQL
* Cassandra
* mongoDB

## HDFS

Optimized for handling really large files by breaking them into blocks and store copies on multiple clusters. There is a single name node that keeps track of where those blocks live and also maintains an edit log. Individual data nodes are what the client will be talking to after tehy are redicrected by the name node and these data nodes talk to each other to maintain copies and replications of those blocks.

![alt text](https://github.com/snknitin/BigData_tech/blob/master/static/hadoopreadwrite.png)

Dealing with a single point of failure for name node:
1) **Back up the metadata constantly to localdisk and NFS**
2) **Maintain a merged copy of edit log that you can restore from in a secondary name node**
3) **HDFS Federation- a hierarchy where each name node manages a specific namespace volume**
4) **HDFS High Availability:**
     * Hot standby name node using shared edit log
     * Zookeper can keep track of which nodes are active
     * Goes to extreme measures to make sure only one name node is used at a time

To load data into HDFS from cli, use putty and SSH maria_dev@127.0.0.1 on port 2222

    hadoop fs -ls  
    hadoop fs -mkdir ml-100k  
    hadoop fs -copyFromLocal u.data ml-100k/u.data  
    hadoop fs -rmdir ml-100k  
  
## MapReduce
 This is natively Java but streaming allows us to write mappers and reducers in python. Mappers transform the input lines into the required structure, usually a (key,value) pair. Shuffling and sorting happens automatically and then the reducers aggregate the keys and perform the fucntion required.
 
    from mrjobs.jobs import MRJob  
    from mrjobs.step import MRStep 
 
 MRJob is an object for the class that you call run() on. Initialize it with a MRStep function which takes a list of mappers and reducers that are defined later in the class.
 

## Pig

So the big problem with mapreduce is just the development cycle time(it takes a long time to actually develop a mapreduce program and run it and get it to do what you want to do). And that's where Pig comes in. It's built on top of map reduce. PigLatin is a SQL like sciprting language that lets you define map and reduce steps andd is highly extensible with user define functions. It runs on top of Tez and is much faster than MapReduce. 

1) Grunt - Command line interpreter that let's you type pig scripts one line at a time and execute them on the master node
2) Script - Save pig sccript to a file and run it
3) Ambari/Hue

These are relations with schema . To make it faster, use Tez which has a DAG that analyzes the interrelationship between different steps and figure out the optimal path for executing things. List of Commands

* LOAD STORE DUMP
* FILTER DISTINCT FOREACH/GENERATE MAPREDUCE STREAM SAMPLE
* JOIN COGROUP GROUP CROSS CUBE
* ORDER RANK LIMIT
* UNION SPLIT
* DESCRIBE EXPLAIN ILLUSTRATE
* REGUSTER DEFINE IMPORT
* AVG CONCAT COUNT MAX MIN SUM SIZE
* PigStorage TextLoader JsonLoader AvroStorage ParquetStorage OrcStorage HbaseStorage


## Spark

Apache Spark is a very quickly emerging technology in the Hadoop Ecosystem. what sets it apart from other technologies like Pig for example is that it has a rich ecosystem on top of Spark that lets you do all sorts of complicated things like machine learning, 
data mining, graph analysis and streaming data. So it's a very powerful framework and a very fast one too and it's scalable. Spark doesn't have to run on Hadoop.. It has it own ccluster manager built in or use Mesos. Unlike a disk based solution where it is hitting HDFS all the time, spark is a memory based solution as each executor process has a task and a cache. DAG engine(Directed Acyclic Graph) optimizes workflows.

* Can code in Python, Java, Scala. Spark itself is written in Scala(compiles to Java Bytecoode and gives fast performance)
* Built around one main concept : **Resilient Distributed Dataset(RDD)**
* Spark streaming - instead of just doing batch processing of data you can actually input data in real time.
* Spark SQL - SQL interface to Spark
* MLLib - Machine Learning library and data mining tools. Break clustering or regression into mappers and reducers
* GraphX - Analyze properties of graphs
* Lazy Evaluation - Nothing actually happens in a driver program until an action is called

### Resilient Distributed Dataset

It is an abstraction, under the spark hood, to make sure jobs are evenly distributed across clusters and you can handle failures in a resilient manner. From a programming standpoint, RDD is just a dataset.  
To make RDD, the driver program is going to create a **SparkContext** (basically the environment that you are running). Spark shell creates an object called "sc".

* You can create an RDD from Hive and use HiveContext(sc) to do SQL queries from spark
* or create RDD from any databse connected to JDBC,Cassandra, HBase, Elastisearch, Data files like JSON,CSV etc 
* Functions on RDD:
  * map - Apply a function to every input row and create a new RDD with 1-1 relation
  * flatmap - This is not restrincted to 1-1 relation
  * filter - Take pout some rows
  * distinct - unique values
  * sample
  * Union, intersection, subtract , cartesian
  * collect  - take the result of all the RDDs and suck them down to driver script
  * count
  * countByValue
  * take
  * top
  * reduce
  
Example 

    from pyspark import SparkConf, SparkContext
    conf= SparkConf().setAppName("<insert a name>")
    sc=SparkContext(conf=conf)
    
    rdd = sc.parallelize([1,2,3,4])
    squaredrdd= rdd.map(lambda x:x**2)   -- > [1,4,9,16]
    
Note:  To put the script on a cluster type **spark-submit <insert-script>.py**
  
  
### Spark SQL and 2.0

Extend RDD to a dataframe object where rows can contain structured data. Dataframe contains row objects which can run sql queries as they have a schema(leading to effecient storage) and can read from or write to JSON, Hive, Parquet. They communicate with JDBC/ODBC,tableau.


    from pyspark.sql import SQLContext, Row
    hiveCxt= HiveContext(sc)
    inputData = spark.read.json(dataFile)
    inputData.createOrReplaceTempView("myStructuredStuff")
    myResultDataFrame = hiveCxt.sql(""" SELECT foo FROM bar""")

Instead of sql we can do things mroe programmatically too
 
    myResultDataFrame.show()
    myResultDataFrame.select("someFieldName")
    myResultDataFrame.filter(myResultDataFrame("someFieldName")>200)
    myResultDataFrame.groupBy(myResultDataFrame("someFieldName")).mean()
    myResultDataFrame.rdd().map(mapperFunction)
 
 
* Dataframe is a Dataset of row objects while Dataset is a general term that cn contaian any sort of info, not just rows
* Spark 2.0 way is to use Dataset and we create a SparkSession object instead of SparkContext
* SparkSession.builder.appName("some name").getOrCreate() 
* Run "export SPARK_MAJOR_VERSION=2" in the cli else you won't be able to import the session


## Hive

Distributing SQL queries across hadoop. This works over Mapreduce and Tez. Bassic concept of Hive is **Schema on read**. It takes unstructured data and applies a schema to it as it is being read. So the data might still be tab limited text file but hive maintains a **metastore** which tells us exactly how to interpret the text files. HCatalog can expose that schema to other services


* Easy OLAP Queries (Online analytics processing), Highly optimized and extensible
* HiveQL works with views which are more of a logical construct and not like a materialized view and allows you to specify how to structure or partition data
* CREATE VIEW IF NOT EXISTS - This will only create if the view wasn't previously created


Cons:
 
* It takes SQL commands and converts them to Mapreduce commans which take sme time, High latency in not appropriate for OLTP
* SQL is limited. Pig and Spark can do a lot more complex operations
* No record level updates, inserts or deletes
* No transactions
* Stores data de-normalized(flat text file and not a relational db)

## Sqoop 

Imports and Exports data from MySQL to HDFS and also does incremental imports using parameters like **--check-column** and **--last-value** to import and only get new data since the last time you added t keep hadoop and relational db in sync. For export create a table ahead of time that matches the schema since sqoop doesn't do it automatically

    sqoop import --connect jdbc:mysql://localhost/movielens --driver com.mysql.jdbc.Driver --tabe movies --hive-import
    
    sqoop export --connect jdbc:mysql://localhost/movielens -m 1 --driver com.mysql.jdbc.Driver --tabe exported_movies --export-dir /apps/hive/warehouse/movies --input-fields-terminated-by '\0001'
    

## NoSQL

To get interactive timescale results across a massive dataset, we use NoSQL. Non relational databases. These scale horizontally forever.

How to make RDBMS to scale to larger data
* Denormalize the tables and pre-materialize the views
* Caching layers on top of the database like Memcache to prevent traffic
* Master/Slave setups
* Sharding db into range partitions
* Remove stored procedures

High transaction queries are probably simple enough once denormalized so we need just a simple get/put api with key value pairs. When you work at a giant scale it is better to use a non-relational db for fast and scalable solutions.  

## HBase

It is a non relational scalable db built on top of hdfs. It doesn't have a query language but it has apis that can very quickly answer the question "what are the values for this key?" or "store this value for this key". It is an implementation of google's BigTable. You can do **CRUD** operations on Hbase. That's it. As your data grows it can automatically scale, shard and distribute it at run time. It works with a master node that keeps track of how the region servers are split up and Zookeeper keeps track of the master incase it breaksdown and handles that bottleneck. the data model is as follow

* Fast access to any given ROW each identified by a unique key value and has a small number of column families(may contain arbitrary COLUMNS)
* Each cell hass many versions with given timestamps
* Sparse data is fine as missing columns in a row consume no storage
* Hbase can be accessed through
 * Hbase Shell
 * Java API with wrappers for scala and python
 * REST services
 * Thrift service
 * Avro service
 * Spark, Hive,Pig


## Cassandra
No single point of failure. NoSQL db with a twist. it does have a query language called CQL. CAP theorom (Consistency,availability,partition-tolerance) states you can have only 2 out of 3. Cassandra favors availability over consistency(eventual consistency). It is actually tunable consisteny. 
* Unlike hbase, it doesn't have amaster node, rather a ring like architecture and uses gossip protocol, so that every node is communicating every second with each other.
* CQL can't do joins since we need denormalized tables and all queries must be on primary key
* Keyspaces (Tables)
* Write spark output into Cassandra
 

## MongoDB

It is a document-based data model. It trades off availability as it uses a master node. You don't need structured data. You can use JSON files as well. You can have different fields in different documents. But you need some unique index if you want to shard. Instead of tables and rows we have -  

* Databases,Collections, Documents

* Replica sets
   * Single master architecture
   * Secondary backup nodes of the database instance. Operation log is long enough to give time for the primary to recover 
   * Even number of servers doesn't wrk since we need majority ot have an agreement on who iss primary. You cna have ariter nodes whose only job is to vote on who should be primary in teh event of a failure
   * Replica sets only address durability and not ability to scale.
   * You can have a delayed secondary with a time delay between replication as insurance. Restoration can be done relatively quickly fom it

* **Sharding** - we actually have multiple replica sets, where each replica set is responsible for some range of values on some indexed value in my database.So in order to get sharding to work, it requires that you set up an index on some unique value on your collection, and that index is used to actually balance the load of information among multiple replica sets, and then on each application server, whatever you're using to talk to MongoDB, you'll run a process called "mongo-S, and "mongos" talks to exactly three configuration servers that you have running somewhere that knows about how things are partitioned and then uses that to figure out which replica set do I talk to to get the information that I want. Ranges can get rebalanced over time. 

  * Auto sharding fails sometimes causing split storms where it cannot spplit things quickly enough and allso if mongos processes get restarted too often
  * You must have 3 config servers
    * This is on top of the single master design of replica sets and if any of them goes down, the DB is down
  * MongoDBB's loose document model can be at odds with effective sharding

**Pros :**  
* Flexible document model
* Shell is a JavaScript interpreter
* Supports many indices but only one can be used for sharding
* Built-in aggregation capabilities for mapreduce,gridFS. Some applications may not nneed Hadoop at all.
* SQL connector is available but can't do joins or deal with normalized data


# Choosing a Database

* Integration considerations
* Scaling requirements
* Transaction rates
* Support considerations
* Budget 
* CAP theorom

![alt text](https://github.com/snknitin/BigData_tech/blob/master/static/CAP.PNG)


# Query Engines

![alt text](https://github.com/snknitin/BigData_tech/blob/master/static/qe.PNG)

## Apache Drill

Drill is just the system that sits on top of your various technologies for storing data, and it basically lets you execute actual SQL queries on top of data that might not even have a schema at all. Based on Google's Dremel. It is an sql query engine for variety of non relational dbs and data files. Can replace Hive. Exposes an interface to other tools that makes it look just like a relational database. This is called ODBC or JDBC, and using that driver, you can connect external tools like Tableau or anything that expects to connect to a relational database and use it just like it's a relational database. SQL without a schema- Internal data representation is JSON


## Apache Phoenix

* This is a non-relational DB that only works with hbase and nothing else. Originally developed by Salesforce
* Fast, Low-latency OLTP support
* Exposes JDBC connector for HBase and has APIs for java
* Supports secondary indices and user-defined functions
* Integrates with MapReduce, Spark,Flume,Hive and Pig and creates jars
* It is really fast and you won't paay a performance cost from habng this extra layer over hbase and it optimizes complex queries though it doesn't support all of SQL
* It is part of client and server




## Presto
## Apache Zeppelin
## 

# Install VirtualBox

Download from https://www.virtualbox.org/wiki/Downloads

# Get an Image from archive

Prefer version 2.5 because the latest ones take a lot of time to boot and Import this into the virtual box. It may take a few minutes as it is 11GB in size

https://hortonworks.com/downloads/

Login to the virtual machine at http://127.0.0.1:8888/  

uname: maria_dev  
pwd: maria_dev  

This takes you to the Dashboard


Directly get to the Ambari page on  http://127.0.0.1:8080/  

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
