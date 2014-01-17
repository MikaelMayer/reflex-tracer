import sbt._
import Keys._
import org.seacourt.build._

object TestBuild extends NativeDefaultBuild("RenderReflex")
{
    lazy val check = NativeProject( "RenderReflex", file("./"), NativeProject.nativeExeSettings )
}

