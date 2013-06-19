Description
===========
This cookbook deploys a redis server. It doesn't do anything special other than customize a few of the redis configuration options.

Requirements
============


Attributes
==========


Usage
=====
You need to set the maxmemory attribute correctly depending on the instance type.  For now it's set to use 90% of memory provided by an m2.xlarge
