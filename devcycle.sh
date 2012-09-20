#!/bin/sh
cd ~/giraph
~/giraph-scripts/build && ~/giraph-scripts/pagerank ; ~/giraph-scripts/filter-logs 
