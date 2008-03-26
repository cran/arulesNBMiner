SOURCES = \
	SparseSetOfItemsets.java Itemset.java Rule.java Association.java \
	R_result.java NBMiner.java
OBJECTS = $(SOURCES:.java=.class)
JARS = arulesNBMiner.jar

JAVAC = javac
JAR = jar

.SUFFIXES: .class .java

.java.class:
	$(JAVAC) -target 1.4 -source 1.4 $<

all: $(JARS)

$(JARS): $(OBJECTS)
	$(JAR) cvf $@ $(OBJECTS)

install: all
	@cp $(JARS) ../inst/jar

clean:
	-@rm -f $(OBJECTS) $(JARS)
