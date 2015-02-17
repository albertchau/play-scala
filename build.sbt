import NativePackagerKeys._

name:= """play-scala"""

version := "1.0-SNAPSHOT"

//mappings in Docker := mappings.value
//
//// setting a maintainer which is used for all packaging types</pre>
maintainer:= "albert@wisttime.com"

// exposing the play ports
dockerExposedPorts in Docker := Seq(9000, 9443)

dockerBaseImage := "dockerfile/java:oracle-java8"
// run this with: docker run -p 9000:9000 <name>:<version>

lazy val root = (project in file(".")).enablePlugins(PlayScala)

scalaVersion := "2.11.1"

libraryDependencies ++= Seq(
  jdbc,
  anorm,
  cache,
  ws
)