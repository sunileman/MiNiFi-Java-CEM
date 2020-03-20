# CEM1.0-Java-MiNiFi

## Docker Instance for Java MiNiFi which connects to Edge Flow Manager UI

This docker instance will build a minifi instance

1.  Git Clone
2.  Build a docker image
  * `docker build --no-cache -t java-minifi .` <br><br>
3.  Run the image with the enviroment file
  * `docker run --env-file=env.file java-minifi`
<br><br>
### Add Nars<br>
Place Nars in a shared location (like s3) and update config.sh.  At run time nars will be pulled into the lib directory
