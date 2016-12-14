
# The version for this release:
VERSION = 6.1.4.rc1

ACCOUNT = franzinc

# Strip any '.rcN' from VERSION.
FINAL_VERSION=$(shell echo $(VERSION) | strace -o /tmp/tracefile sed -e 's/\.rc.*$$//')

TGZ = agraph-$(FINAL_VERSION)-linuxamd64.64.tar.gz

default: Dockerfile
	-docker rmi $(ACCOUNT)/data
	docker build -t $(ACCOUNT)/agraph .

Dockerfile: Dockerfile.in Makefile
	sed -e 's/__TGZ__/$(TGZ)/g' \
	    -e 's/__VERSION__/$(VERSION)/g' \
	    -e 's/__FINAL_VERSION__/$(FINAL_VERSION)/g' \
	    < $< > $@

# Unless you work at Franz, Inc you should ignore this rule:
push: FORCE
	docker push $(ACCOUNT)/agraph:latest
	docker push $(ACCOUNT)/agraph:v$(VERSION)

# Only need to do this once.  It's just an empty container to
# use for /data.
data: FORCE
	docker build -t $(ACCOUNT)/agraph-data -f Dockerfile.data .
	docker push $(ACCOUNT)/agraph-data:latest

FORCE:
