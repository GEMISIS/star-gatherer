# Star Gatherer
Star Gatherer is a simple NES game built using [cc65](https://cc65.github.io/), a toolset for building for the 6502 chip. To get started, setup cc65 on your desired platform as well as [GNU Make](https://www.gnu.org/software/make/). You can then run **make** in the root directory to build the project.

# Setup
The project is structured pretty simplisticly: the majority of the source code is in the **source** folder, while any headers are in the **include** folder. You can just add files to these directories as necessary and it will automatically pick up everything necessary and compile it. The generated file will be titled based on whatever the root directory is called. In this case, if you clone this project, it should be **star-gatherer**, so the resulting NES binary should be **star-gatherer.nes**.

# Building
To build, you can just run **make** in this directory to build the project. You can clean it all by running **make clean**. When building for the NES, you can include a linker configuration file like shown [here](https://github.com/depp/ctnes/blob/master/nesdev/01/link.x). To use this in your project here, simply include a single configuration file with the **.x** extension in the source folder, which will automatically be picked up and used. You can also exclude this to use cc65's default NES targeting.