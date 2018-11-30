# Elk+graylog2 backup and restore scripts for elasticsearch and mongodb

##### (backup scripts for config files not included)

##### Backup and restore scripts for mongodb and elasticsearch to ELK+Graylog2

## Read all Before backup or restore process initialization!

# Setting your repo name first if you backup or restore process on a new server!

* setting_your_repository.sh script, specify ADD_YOUR_NAME_REPO_HERE and ADD_LOCATION_HERE variable. run him!
* add to cron elastic_snapshot.sh script.
* add to cron mongodb-backup.s, specify LIMIT_DAYS variable and specify backup directory.
* add to cron remove_backup.sh, specify LIMIT and REPO variable.


