java_src_dir=$(CURDIR)/src/main
resources_dir=$(CURDIR)/src/resources

jar_dir=$(CURDIR)/lib
jars="$(jar_dir)/java-cup-11b.jar:$(jar_dir)/java-cup-11b-runtime.jar"
classpath="$(java_src_dir):$(jars)"

compiled_bins=$(CURDIR)/bin
bin_classpath="$(compiled_bins):$(jars)"


# For converting *.flex to *.java files
.SILENT: convert
convert:
	echo "Converting to .java files..."

	jflex --nobak --quiet -d $(java_src_dir) $(resources_dir)/Lexer.flex
	jflex --nobak --quiet -d $(java_src_dir) $(resources_dir)/LexerCup.flex
	java -jar lib/java-cup-11b.jar -locations \
		-parser Parser \
		-destdir $(java_src_dir) $(resources_dir)/Syntax.cup


# For compiling *.java files to *.class binaries
.SILENT: compile
compile:
	echo "Compiling..."
	javac --class-path $(classpath) -d $(compiled_bins) $(java_src_dir)/*


.SILENT: compile-main
compile-main:
	echo "Compiling..."
	javac --class-path $(classpath) -d $(compiled_bins) $(java_src_dir)/Main.java


# Run the Main.java file
.SILENT: run
run:
	java --class-path $(bin_classpath) Main


.SILENT: with-args
with-args:
	java --class-path $(bin_classpath) Main parser test/inputSyntax.txt
