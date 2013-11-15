reflex-tracer
=============

Reflex Tracer in C++ / AutoIt3

![Interface in 2.8](ReflexRendererInterfaceV2.8.png)

ReflexRenderInterface  2008/07/05

To use this software, you must agree with the End-User License Agreement.
(See below).

This is a friendly user interface for the main reflex renderer, written in AutoIt3.
 
If you do not know yet what a Reflex is, go to the [Youtube Video](http://www.youtube.com/watch?v=iHw6Hgs_qJ0)
or [Mikaël Mayer's website](http://www.mikaelmayer.com/reflex)
to figure it out.

Now, you can play, create, save and explore your own creations!

*************************

Tips
----

- If you click on the picture, you can drag it.
- Use "A" to drag, "Z" to zoom in, and "E" to zoom out.
- Use "R" to go to the previous window, and "T" to go to the next one.

************************

FAQ
---

Q: Why are the functions randf and randh always giving the same formulas?
A: This is a current limitation due to the fact that the seed used in the main program, is always the same.
The Pocket PC version does not have this problem.

Q: Why are the errors not displayed at the right place? I wrote an unknown function test(z+1) but it told me that the error was at the right parenthesis!!
A: The program tries to interpret the function as soon as it have the arguments. But I will work on that.

Q: I hit the QuickSave button, but I don't know where it has been saved!!
A: Check Tools > Save Reflex/Formula to check it out.

Q: When I zoom too much, the Reflex becomes unicolor!
A: This is a precision problem. If you want to zoom more precisely to a specific part, consider this code:
o(f(z),z-(A+Bi)),
where A+Bi is the complex you would like to center the reflex on.

Q: But even if I do that, I can zoom a little bit more, but I get the same problem again!
A: This is a precision problem. The current implementation uses standard double-precision.

Q: Rendering is too slow!
A: Consider checking "Preview" and put a low number in the percentage input, if you want to have a faster preview.
Byt the way, I'm working on a parallelization algorithm to make it faster, and to use all the cores of a computer.
But this is not finished yet. Be patient.

Q: I got some problems unmentionned in the FAQ
A: If you really need to contact the creator, go to the About box.

 /************************************
 *    End-User Licence Agreement     *
 ************************************/

* The author of this software cannot be responsible for any damage that the application could have caused to your machine, or to any machine the program is running on.
* You may freely redistribute this copy of the software, but not modify it. To modify the copy, contact the author for permission.
* You may uncompile the main binary (the interface), but this is rather a bad idea. Consider asking the sources to the author.
* The core program is not yet open-source.
* You cannot sell any part of this program.
* Don't be evil. Be fair.