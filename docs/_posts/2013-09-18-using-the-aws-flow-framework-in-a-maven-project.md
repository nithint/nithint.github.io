---
title: Using the AWS flow framework in a Maven project
date: 2013-09-18 10:08:06.000000000 -07:00
classes: wide
categories:
- programming
- aop
- aws
- maven
- netbeans
- swf
- workflow
permalink: "/2013/09/18/using-the-aws-flow-framework-in-a-maven-project/"
---

Recently, I've had to use the SWF flow framework for Java for an
existing project using Maven. The developer guide and online examples
only talk about using Eclipse and Ant and so I had to do some googling
to find out how.

I wasted a lot of time looking into Aspect Oriented Programming (AOP)
and finding out that Netbeans doesn't support it and then trying to use
the maven-processor-plugin. But in the end it turned out pretty simple
and easy. The solution was more or less given in this [stack overflow
answer](http://stackoverflow.com/a/9677828/567184 "Stack Overflow"). But
that goes into more background detail than necessary. I just wanted to
get the basic steps to get going and I've copied it here.

1.  Install the AWS JAVA SDK - download from
    <http://aws.amazon.com/sdkforjava/>
2.  Install the flow framework jar with maven using the following
    command. You must run this command from the lib folder of the AWS
    SDK installation folder which will contain the
    aws-java-sdk-flow-build-tools jar file.\
    `mvn install:install-file -Dfile=aws-java-sdk-flow-build-tools-<version>.jar -DgroupId=com.amazonaws -DartifactId=aws-java-sdk-flow-build-tools -Dversion=<version> -Dpackaging=jar`
3.  Add the following dependencies to your project pom. Note that I'veput the versions that I'm currently using. If you've moved to a newer version, then use that version number. The versions here have been tested as working.\
    ~~~xml
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
      </dependency>
      <dependency>
      <groupId>com.amazonaws</groupId>
      <artifactId>aws-java-sdk</artifactId>
      <version>1.5.5</version>
      </dependency>
      <dependency>
      <groupId>org.aspectj</groupId>
      <artifactId>aspectjrt</artifactId>
      <version>1.7.3</version>
      </dependency>
      <dependency>
      <groupId>com.amazonaws</groupId>
      <artifactId>aws-java-sdk-flow-build-tools</artifactId>
      <version>1.5.5</version>
      </dependency>
      <dependency>
      <groupId>org.freemarker</groupId>
      <artifactId>freemarker</artifactId>
      <version>2.3.18</version>
      </dependency>
      <dependency>
      <groupId>log4j</groupId>
      <artifactId>log4j</artifactId>
      <version>1.2.17</version>
    </dependency>
    ~~~
4.  The last piece of the puzzle is to put together the build so that the aspject weaving takes place at the right build step. Configure your pom build section like so:
    ~~~xml
    <build>
      <plugins>
        <plugin>
          <groupId>org.codehaus.mojo</groupId>
          <artifactId>apt-maven-plugin</artifactId>
          <version>1.0-alpha-5</version>
          <executions>
            <execution>
              <goals>
                <goal>process</goal>
              </goals>
            </execution>
          </executions>
        </plugin>
        <plugin>
          <groupId>org.codehaus.mojo</groupId>
          <artifactId>aspectj-maven-plugin</artifactId>
          <version>1.5</version>
          <configuration>
            <aspectLibraries>
              <aspectLibrary>
                <groupId>com.amazonaws</groupId>
                <artifactId>aws-java-sdk</artifactId>
              </aspectLibrary>
            </aspectLibraries>
            <complianceLevel>1.6</complianceLevel>
            <showWeaveInfo>true</showWeaveInfo>
            <verbose>true</verbose>
            <sources>
              <source>
                <basedir>${basedir}/target/generated-sources/annotations</basedir>
              </source>
              <source>
                <basedir>src/main/java</basedir>
                <includes>
                  <include>**/*WorkflowImpl.java</include>
                <include>**/*ActivitiesImpl.java</include>\
              </includes>
              </source>
            </sources>
          </configuration>
          <executions>
            <execution>
              <goals>
                <goal>compile</goal>
                <goal>test-compile</goal>
              </goals>
            </execution>
          </executions>
        </plugin>
      </plugins>
    </build>
    ~~~
5.  And that's it. You are done!

I use Netbeans and netbeans automatically takes care of showing the
generated source files as part of the IDE and adding them to the
buildpath.

### A little back story

I followed through pretty much the instructions on the stack overflow
answer and that was enough to get me started. Then I added an activity
and tried to use the ExponentialRetry annotation and things started
failing. I also noticed that asynchronous methods in my test weren't
exactly being called asynchronously. I searched through the aws forums
and stumbled upon this
[gem](https://forums.aws.amazon.com/thread.jspa?messageID=424555&#424555)
that led me to the current build configuration that I have now.
Basically what it means is that the auto generated classes need to be
generated first before the aspectj weaving takes place and you have make
sure to include the autogenerated sources as part of your aspjectj weave
as you can see by looking at the sources for the aspectj plugin. Also,
I'm selecting my activities and workflow classes using the wildcard \*
selector based on my filename naming convention. You may need to change
it to fit your project.

Now when you compile your project, you should see an additional step
\[aspectj:compile\] and it will tell you which files were found to have
the annotations and which annotations were processed.
