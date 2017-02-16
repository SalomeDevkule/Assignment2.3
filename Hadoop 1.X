HDFS – Hadoop Distributed File System
HDFS is responsible for storage.
HDFS in Hadoop 1.x mainly has 3 daemons which are:

Name Node
There is only single instance of this process runs on a cluster and that is on a master node
It is responsible of managing metadata about files distributed across the cluster
It manages information like location of file blocks across cluster and it’s permission
This process reads all the metadata from a file named fsimage and keeps it in memory
After this process is started, it updates metadata for newly added or removed files in RAM
It periodically writes the changes in one file called edits as edit logs
This process is a heart of HDFS, if it is down HDFS is not accessible any more

Secondary Name Node
For this also, only single instance of this process runs on a cluster
This process can run on a master node (for smaller clusters) or can run on a separate node (in larger clusters) depends on the size of the cluster
One misinterpretation from name is “This is a backup Name Node” but IT IS NOT!!!!!
It manages the metadata for the Name Node. In the sense, it reads the information written in edit logs (by Name Node) and creates an updated file of current cluster metadata
Than it transfers that file back to Name Node so that fsimage file can be updated
So, whenever Name Node daemon is restarted it can always find updated information in fsimage file

Data Node
There are many instances of this process running on various slave nodes(referred as Data nodes)
It is responsible for storing the individual file blocks on the slave nodes in Hadoop cluster
Based on the replication factor, a single block is replicated in multiple slave nodes(only if replication factor is > 1) to prevent the data loss
Whenever required, this process handles the access to a data block by communicating with Name Node
This process periodically sends heart bits to Name Node to make Name Node aware that slave process is running
Hadoop 1.x has a Single Point Of Failure
As per above description, HDFS has only one Name Node so if that process or machine goes down complete cluster goes down. That is why Name Node in Hadoop 1.x is considered to be a Single Point of Failure.


MapReduce – Distributed Computation
MapReduce component is responsible for processing on Hadoop Cluster. Basically it uses two daemons named Job Tracker and Task Tracker. Hadoop MapReduce algorithm basically has two phases Map and Reduce.

Job Tracker
Only one instance of this process runs on a master node same as Name Node
Any MapReduce job is submitted to Job Tracker first
Job Tracker checks for the location various file blocks used in MapReduce processing
Than it initiates the separate tasks on various Data Nodes(where blocks are present) by communicating with Task Tracker Daemons
Task Tracker
This process has multiple instances running on the slave nodes(typically runs on the slave nodes where Data Node process is running)
It receives the job information from Job Tracker daemon and initiates a task on that slave node
In most of the cases, Task Tracker initiates the task on the same node where there physical data block is present
Same as Data Node daemon, this process also periodically sends heart bits to Job Tracker to make Job Tracker aware that slave process is running.
