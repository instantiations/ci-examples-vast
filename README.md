<p align="center">
<!---<img src="assets/logos/128x128.png">-->
 <h1 align="center">Continuous Integration Examples for VASmalltalk</h1>
  <p align="center">
    Implementing Continuous Integration with VA Smalltalk!
    <!---
    <br>
    <a href="docs/"><strong>Explore the docs »</strong></a>
    <br>
    -->
    <br>
    <a href="https://github.com/vasmalltalk/ci-examples/issues/new?labels=Type%3A+Defect">Report a defect</a>
    |
    <a href="https://github.com/vasmalltalk/ci-examples/issues/new?labels=Type%3A+Feature">Request feature</a>
  </p>
</p>


The system presented here can be used for automatically building VASmalltalk images for custom applications from Jenkins as well as manually from the command line (if developers want an ad-hoc image for testing). In other words, provide repeatable and automated image creation so that anyone could do it and do it quickly.

The idea is to help others that may also want to automatically build their applications images and thus to get community co-operation in improving this system so we can all benefit.  


## License
- The code is licensed under [MIT](LICENSE).
- The documentation is licensed under [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/).


## General Requirements

This system is only a part of the solution and relies on you having configuration maps containing everything you need to create your application (including dependencies). If you don't have these already, it cannot really help too much as this is a per-requisite of this solution. Basically, you need to be able to build your applications manually from a clean 'new' image to then automate the process.

The provided example assumes that Windows is the primary build environment and that UNIX is the XD environment. If Linux is your primary build environment, you would only have to adapt the batch scripts to shell scripts and change the UNIX.txt file (which defines the XD image properties) to be a different platform.

This build system also assumes VAST 9.2.1 although the only thing that makes that assumption is the paths used in the batch files. However, this will work in any VA version >= 8.6.2 (where the [PostStartUp capability in image startup scripts exists](https://www.instantiations.com/docs/91/sg/wwhelp/wwhimpl/common/html/wwhelp.htm#href=stug515.html&single=true)). You just have to change the paths to `nodialog.exe` and `newimage\abt.icx` to match your installation.


## Getting Started

### Pre-requisities

This solution assumes you have the following configuration maps:

1. *Build*: a map that has all the features needed by your application along with all the packaging instructions classes for your application. If you need to build XD images, you need this config map to include all the XD packaging support. This map may also includes VAST Goodies or any 3rd party applications you use. Although that is a personal choice to cut down the time it takes to create the applications images.

2. *XD*: If you need to build an XD image, a config map containing the maps and apps needed by the XD image for your application.

3. *Application*: a config map for your application.

### High Level Flow

The solution involves two basic steps:

1. Build an image that is used as the basis image ("build image") from which the application image is built. If you build images manually, this takes the place of the "Master" image you always load to create a release image. You may have a single "build image" from which you build many "applications images".  The "build image" is the one that the config map containing all the features is put into. Normally, you would only re-build this image if you change the config map used by this image - which may happen only really at VAST major release boundaries.

2. Using this "build image", then load the application config map and run the packager for the application. Note that the way things are written right now, the packaging instructions for the application must exist in the "build image".  If you try this out and it cannot find the packaging instruction class, they it's likely you have it in the "application config map" rather than the "build config map".


### Components

There are very few components involved:

- You will need to supply your own `abt.ini` with the reference to your ENVY library and any parameters you need. Otherwise, you can get the default from `\newimage\abt.ini`.

- `abt.cnf`: The initial image startup script used to create the "build image". This takes the following command line options:

  - `user=yourusername` that will own the image.  Must be a user (`EmUser >> #uniqueName`) in the ENVY library.

  - `map=BuildMap` that points to the features you need in the main build image.

  - `xdmap=XDMap` optional argument if you need an XD image listing the config map for the features to put into the XD Image.

- `UNIX.txt`: A text file used by the XD image creator that defines the properties of the XD image.  Note that while this file has a place to define `InstalledFeatures`, this list is ignored by the XD subsystem.  Instead, you will find a bit of code in `abt.cnf` that does `xdImage installFeatures:` that will load features not in your config map

- `build.cnf`: The image startup script used by the "builder image" to create your final "application images". This takes the following command line options:

  - `map=ApplicationConfigMap` which is your application config map.

  - `pkg=PkgInstructionName` which is the name of the packaging instruction class to use.

  - `ver=<version>` Optional version number of the application config map to load.  If no version is supplied, the latest edition of the config map (versioned or not) is built.  Else the latest versioned config map which has the string `V<version>` in it is built.

- `create_builder.cmd`: A sample Windows batch file to make it quick to create new builder images.  You will have to edit this for your own setup.

- `build_image.cmd`: A Windows batch file to use the build image to create application images.  You might have to edit this for your own setup.

The provided scripts assume a 3 segment version number for the config maps:  `V<major>.<minor>.<patch>`.  If you use a different versioning scheme you will need to change the edition detect logic in `build.cnf`.

The `build.cnf` looks at the type of packaging instruction supplied on the command line.  If it is an XD packaging instruction, the config map and version is loaded into the development image and XD image and the XD packager is invoked.

### Outputs

You will (hopefully) get all the outputs configured in your packaging instruction (final `.icx` , `.SNP`, `.es` files, etc). In addition, we generate an HTML snippet containing the description of the config map edition being built. You may use this as part of a release note generator for releases.

## Seaside Traffic Light Example

The provided scripts in this repository are prepare to build and package the "Seaside Traffic Light" example shipped with VA 9.2.1 out of the box.

### Setup

Decide which ENVY manager you want to use (should be based on 9.2.1 for this example) and copy a correct configured `abt.ini` (that points to the manager to use) into your local clone of this repo.

Import and load the maps `Seaside Traffic Light XD` and `Seaside Traffic Light Builder` from [`SeasideTrafficLightMaps.dat`](envy/SeasideTrafficLightMaps.dat) into the selected manager.


### Running

1. Open a CMD terminal on the local clone of this repo.
2. Create the build by running `create_builder.bat`.
3. Build a Seaside Traffic Light image by running `build_image.bat`.
4. Confirm you got the `seasideTrafficLight.icx`, `SEASIDETRAFFICLIGHT.SNP` and `*.es` files.
5. Move `seasideTrafficLight.icx` to UNIX.
6. Run it with the [Server Runtime distribution](https://www.instantiations.com/products/vasmalltalk/download.html): `./abtnx -iseasideTrafficLight.icx -ini:abtnx.ini`
7. Open a browser and validate that the webapp is running in http://localhost:7777/trafficlight


## Jenkins tips and tricks

Jenkins cannot consume the `-lCON` output generated by `abt,exe/nodialog.exe`.  It assumes that the output it will grab is generated directly by the command that is being executed.  To get around this, we tell `abt.exe` to write to a file (`output.txt`) and once the operation is completed we output this file to jenkins. This means that the console output in Jenkins is not updated while an image is being built - only at the end.

The second tip is that it is not easily possible to run the packager in a purely headless mode.  This means it requires a desktop to work.  Jenkins only runs a slave build on a desktop if the agent is run from a desktop - and not as a Windows service.  While the build will still run if your run it as a build job on a Windows service jenkins slave, you will not be able to resolve any issues with the build job (as you will have no UI).

You could have one build job to create the `build.icx` which is then archived as an artifact by Jenkins. The application image build jobs then copy this artifact as part of the application image build jobs. The output images could then be fed to build jobs that do the final packaging and distribution (eg with the VA smalltalk runtime DLLs, pictures and related resources).

## Future work

- Run tests and ouput JUnit XML format.
- Provide Jenkins job demo for Seaside Traffic Light.
- Improve VAST to minimize required changes in the process.
- Analyze how this related with [Tonel](https://github.com/vasmalltalk/tonel-vast) and [Smalltalk CI](https://github.com/hpi-swa/smalltalkCI)


## Acknowledgments

- David Gregory and [Trapeze Group](https://trapezegroup.com.au/) for making [the first pass of this project, the documentation, and for kindly sharing it with the community](http://forum.world.st/Automatically-building-Application-Images-via-Jenkins-CLI-td5109957.html) with an open-source license.  
- Thomas Koschate and Marten Feldtmann for the [Automated Build Support](http://vastgoodies.com/projects/Automated%2520Build%2520Support) project which showed the main techniques and proved it could be done.
- [Thomas Koschate’s 11 part blog series on packaging](https://omasko.wordpress.com/2011/03/27/improving-the-development-process-part-1-setting-the-scene/) which provided some explanations.
- Louis Barunda and [his post about Seaside XD packaging](https://groups.google.com/forum/#!msg/va-smalltalk/5_N1LYHsfxg/FMj1Ae2DCwAJ).
- [Mercap Software](https://github.com/Mercap) for show sharing code, ideas and fixes.
- Github repository layout was generated with [Ba-St Github-setup project](https://github.com/ba-st/GitHub-setup).


## Contributing

Check the [Contribution Guidelines](CONTRIBUTING.md)
