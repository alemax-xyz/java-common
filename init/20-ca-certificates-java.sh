#!/bin/sh

find /usr/share/ca-certificates -type f | xargs -I % echo +% | java -Xmx64m -jar /usr/share/ca-certificates-java/ca-certificates-java.jar > /dev/null
