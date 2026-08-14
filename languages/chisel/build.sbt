scalaVersion := "2.13.14"

libraryDependencies += "org.chipsalliance" %% "chisel" % "6.5.0"
addCompilerPlugin("org.chipsalliance" % "chisel-plugin" % "6.5.0" cross CrossVersion.full)

scalacOptions ++= Seq("-language:reflectiveCalls", "-Ymacro-annotations")
