
resolvers += Resolver.file("sbt-cpp", file("C:\\Users\\Mikael\\Dropbox\\workspace\\sbt-cpp\\releases"))( Patterns("[organisation]/[module]_[scalaVersion]_[sbtVersion]/[revision]/[artifact]-[revision].[ext]") )

addSbtPlugin("org.seacourt.build" % "sbt-cpp" % "0.1.+")

addSbtPlugin("com.typesafe.sbteclipse" % "sbteclipse-plugin" % "2.3.0")