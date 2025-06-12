# A Step-by-step Guide to Deploying Python Models on Db2 with Python UDF

Python UDF is a feature in IBM Db2 that allows users to incorporate their own Python functions into Db2. Users can easily apply these functions to Db2 data using SQL statements. Python UDFs have endless potential in supporting various use cases, such as creating Python models with scikit-learn outside of the database and then deploying these models on Db2. By deploying these models on Db2, users can generate predictions without moving data to a separate system. IBM Db2 seamlessly integrates Python and SQL into one system through Python UDF, providing a convenient SQL interface for accessing this combined functionality. With Python UDF, integrating Python models and downstream applications becomes simpler. In this tutorial, you will learn how to create a Python model using Db2 data and deploy it on Db2. Then, I will show you how to use the deployed model to generate predictions on Db2 data using SQL. 

# Lab steps
1. setup Db2 tables:
   ```shell
   db2 -tvf 1-createtb.sql
   ```

2. create UDF:
   ```shell
   db2 -tvf 2-createudf.sql
   ```

3. call UDF:
   ```shell
   3-runudf.sql
   ```

Read the full walkthrough: [Streamline Python Model Deployment and Integration with IBM Db2](https://community.ibm.com/community/user/blogs/shaikh-quader/2024/05/27/db2ai-pyudf)
