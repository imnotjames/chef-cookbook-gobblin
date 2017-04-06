# Gobblin Chef Cookbook

This is a chef cookbook to set up a deployment of [LinkedIn's Gobblin](http://gobblin.readthedocs.io/en/latest/) -
a universal data ingestion framework for extracting, transforming, and loading large volume of data from a
variety of data sources.

## Attributes

### Common

| Key | Type   | Description | Default |
|-----|--------|------------ |---------|
| ['gobblin']['version'] | String | Gobblin Version to Install | '0.9.0' |
| ['gobblin']['install-directory'] | String | Where to install Gobblin to. | '/opt/gobblin' |
| ['gobblin']['log-directory'] | String | Where to have gobblin write its logfiles. | '/var/log/gobblin' |
| ['gobblin']['job-directory'] | String | Where to have gobblin look for jobs. | '/etc/gobblin/jobs' |
| ['gobblin']['user'] | String | The user gobblin gets installed as. | 'gobblin' |
| ['gobblin']['group'] | String | The group gobblin gets installed as. | 'gobblin' |
| ['gobblin']['home-directory'] | String | The gobblin "home" directory. | '/home/gobblin' |


### gobblin::install

| Key | Type   | Description | Default |
|-----|--------|------------ |---------|
| ['gobblin']['install']['distribution-url'] | String | URL for distribution tarfile | "https://github.com/linkedin/gobblin/releases/download/gobblin_#{node['gobblin']['version']}/gobblin-distribution-#{node['gobblin']['version']}.tar.gz" |
| ['gobblin']['install']['distribution-checksum'] | String | Distribution tarfile checksum | 'b1b236e5409ff10810daf310664fd0667cc358cd2937c7ff68e0845dd8fa182a' |

## Recipes

### gobblin::default

The default runs `gobblin::default`

### gobblin::install

Downloads the Gobblin framework and installs it.
