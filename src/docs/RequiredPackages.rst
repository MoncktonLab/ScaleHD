.. _sect_reqpack:

Software Dependencies
================================

ScaleHD functions entirely on open-source software, and itself is open-source. As ScaleHD is primarily a Python based package, certain Python libraries are required for it to work properly. These dependencies should be installed upon running the installer script, or when installing the package from PIP. However, if you are curious as to what packages are used (and which versions..) then you can find that information here.

Python Packages
~~~~~~~~~~~~~~~

All software packages have an accompanying version number listed. These are the versions of each package from which ScaleHD was developed. Newer versions may function fine, but are not tested. It is highly recommended to avoid older versions, and if possible, use the exact same version as during development. If you do not want to overwrite any packages of which you have a newer version, please see the sub-section in :ref:`detailed-install` about utilising virtual environments.
As of ScaleHD version 0.321, dependencies have been updated to the latest available stable versions (at the time of writing). Syntax interaction for a few dependencies had changed, so ScaleHD may not function properly with versions other than that listed here.

 * cutadapt (1.18)
 * generatr (0.252)
 * batchadapt (0.22)
 * lxml (4.3.2)
 * matplotlib (2.2.4)
 * numpy (1.16.2)
 * pandas (0.24.1)
 * peakutils (1.3.2)
 * seaborn (0.9.0)
 * PyPDF2 (1.26.0)
 * pysam (0.15.2)
 * regex (2018.11.22)
 * reportlab (3.5.12)
 * scipy (1.2.1)
 * sklearn (0.20.2)

Third Party Binaries
~~~~~~~~~~~~~~~~~~~~

ScaleHD also uses third party binaries to carry out certain functions. These binaries are expected to exist on your system $PATH variable, so they can be called by a UNIX subprocess without invoking a shell (as this is a huge security risk and generally bad design, and anyone who uses shells within a subprocess should feel bad about themselves). For more information on how to put binaries on your $PATH, please see the section :ref:`installation`. As the user can select which stages of ScaleHD to run, only the binaries utilised in each selected stage will be required. *However, for peace of mind it is recommended to just provide all required third party binaries on your $PATH anyway*. As with python dependencies, a software version is listed. Newer versions of dependencies may work with ScaleHD; using older versions is not recommended.

 * Java (1.8.0_20)
 * FastQC (0.11.7)
 * SeqTK (1.3-r106)
 * BWA-MEM (0.7.17-r1188)
 * Samtools (1.9)
 * Picard (2.18.23)
 * FreeBayes (v1.2.0-2-g29c4002)

.. _installation:

Installation
============

As ScaleHD is a pipeline with a potentially varied userbase (in terms of background), certain users may need more instructions on how to get the software up and running. As such, the documentation for installation is split into two sub-sections. For users who are comfortable with UNIX systems, command line terminals and general package/dependency management, please read the section :ref:`quick-install`. For other users, who may never have used UNIX before, or are uncomfortable with command line interfaces, please see the :ref:`detailed-install`.

As I have developed the software on OS X, and most of the end-users in our lab will be running the pipeline on this operating system, instructions are tailored to it as a result. **However**, if you are using a GNU-UNIX type operating system (Ubuntu, for example), there will be notes on how to install ScaleHD for your OS, too. ScaleHD has been developed on OS X 10.11.6 and tested on OS 10.10-10.11.6, as well as Ubuntu 14.04 LTS.

.. _quick-install:

Quick Instructions
~~~~~~~~~~~~~~~~~~

If you know your way around a terminal, these instructions are for you.

ScaleHD uses Python 2.7.14, so ensure your target for package installation is the correct version of Python on your system.

::

  pip install scalehd

This will install all python dependencies for you. Depending on your user privilege level, you may want to use sudo. For each third party binary, please compile the source to your systems specification, or use a pre-compiled binary provided by the developer. Add an entry to your $PATH for each of 'java', 'fastqc', 'seqtk', 'bwa', 'samtools', 'r' and aliases for 'picard' and 'gatk'. **These binaries must be as listed here, in lower case.** This pipeline has only been tested on bash and zsh, so other shells may exhibit unexpected behaviour(s). Once you have augmented your $PATH as above, you are good to go.

.. _detailed-install:

Detailed Instructions
~~~~~~~~~~~~~~~~~~~~~

If you're new to UNIX, bioinformatics, or command line interfaces in general, these instructions are for you. We will install ScaleHD from a completely clean install, step-by-step. This means, we assume your UNIX operating system has no dependencies installed at all, and requires everything installed from scratch. We assume absolutely zero knowledge of any techniques required to install and use ScaleHD, so it will be very in-depth. Let's begin!

Before we install anything related to ScaleHD, it is worth mentioning that if you are also working on OS X, you will be required to install command line tools to make the remaining installation procedure possible. To do this, open a terminal. Press ⌘+Space to open spotlight search, and type "Terminal". In this prompt, type the command:

::

  xcode-select --install

A GUI prompt will appear; press 'Install'. This will download a ~130MB package and install it for you. You need not do this on Ubuntu as Canonical have the sense to include a C++ compiler and package manager with their operating system, whereas Apple do not.

The next step is to install PIP. PIP is a Python package manager, which allows you to install software from the Python package index, over the internet, without being required to get dependencies manually. Your computer system may already have PIP installed, but incase it doesn't, we will install it here. You need to download the Python script get-pip.py from https://bootstrap.pypa.io/get-pip.py. Once you have this downloaded, we need to run it to install PIP.

The next step is to run the script. Go back to your terminal which you opened previously, and prepare to enter a new command.

.. warning::
    PIP requires Python to function. If you are working on OS X or any modern version of Ubuntu, you already have Python 2.7 installed, and do not need to do anything else. If you lack access to Python 2.7, contact your system administrator to get it installed, or see https://www.python.org/downloads/release/python-2713/.

.. note::
    Throughout these instructions, we will refer to a "builds" directory, where we will be installing third-party binaries. In our examples, we have used the folder path '/Users/alastairm/Documents/Builds', wherein will be subfolders for each binary. How you allocate your binaries is up to you, but this tutorial will follow this builds directory format.

.. image:: img/install-term.png

Now we run our downloaded script to install PIP. Assuming that your script is in your user Downloads folder (/Users/user-name-here/Downloads/), we will execute the following command:

::

  python2 ~/Downloads/get-pip.py

The specific command you need to run will depend on the location that you chose to download get-pip.py. Regardless, This will install PIP onto your system, allowing you to install ScaleHD and any Python-based dependencies with no effort at all. In order to do that, in the same terminal, issue a new command:

::

  pip install scalehd

This will install all python dependencies for you. Depending on your user privilege level, you may want to prefix the above command with 'sudo', which will run the command at an administrator level. If you are unsure, talk to your system administrator. Now that ScaleHD and its dependencies have been installed, we need to install the required third-party binaries which are not available for installation from PIP.

.. warning::
    For all the following third-party binaries, ScaleHD attempts to detect binaries with a lower case filename. If your binary files are called something else, ScaleHD will be unable to locate them on your $PATH. Please ensure that your binaries are all respectively named 'fastqc', 'seqtk', 'bwa', 'samtools' and 'r'. ScaleHD also requires aliases for 'picard' and 'gatk', which we will cover in their respective sub-sections.

Java (1.8.0_20)
~~~~~~~~~~~~~~~

Java is required for certain packages to run, but is normally distributed as part of any UNIX based operating system and should already be installed on your system. To check, open a terminal and type the command:

::

  java -version

This will return a string, telling you which version of Java is installed (if any). ScaleHD has been developed with 1.8.0_20 installed, but any 1.8 version of Java should function the same. If you do not have Java installed, please install the Java Development Kit **and** the Java Runtime Environment for your system. See http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html and http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html for more information.

FastQC (0.9.2)
~~~~~~~~~~~~~~

.. _install-fastqc:

    FastQC is a bioinformatic tool which generates visual reports on the quality of a particular input sequence data from NGS platforms. It is available as a GUI (graphical user interface) based program, but we need to acquire a version which runs as a command line tool so that ScaleHD can run it in a pipeline. To do this, please download FastQC from https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc. Regardless if you are using OS X or Ubuntu, please download the Win/Linux zip file. Extract this zip, then locate the binary titled "fastqc". Copy this binary file to your Builds folder, then open a terminal.

.. note::
    We will now add FastQC to our $PATH. By default, OS X and Ubuntu will be using the BASH environment, so these instructions are for BASH. If you are using an alternative shell, you are advanced enough to know how to add things to your $PATH already and shouldn't really be reading this.

We are going to edit a text file in our terminal. Here, the program 'nano' is used, but you can use whichever editor you prefer.

::

  nano ~/.bash_profile

This will open a screen, similar to this (but your file will be blank):

.. image:: img/edit-bashprofile.png

Adding things to your $PATH is as simple as typing the following:

::

  export PATH="/usr/local/bin:/path/to/your/binary/file:$PATH"

for each binary. In our example case of the Builds directory, and for FastQC, we would thus type:

::

  export PATH="/usr/local/bin:/Users/alastairm/Documents/Builds/FastQC:$PATH"

And now, FastQC is on our system's $PATH, and can be called/executed from any location in the shell. However, before we do that, you need to 'apply' the changes. This is done by sourcing your bash_profile file:

::

  source ~/.bash_profile

Alternatively, you can restart your terminal application, or log out and log in.

SeqTK (1.2-r101-dirty)
~~~~~~~~~~~~~~~~~~~~~~

As the methodology for adding binaries to your path has been covered in :ref:`install-fastqc`, we will not cover it again for every single binary. SeqTK is available at https://github.com/lh3/seqtk, where you will also find instructions on how to compile the application for your system. Once compiled, move the binary to your Builds folder, and add that directory to your $PATH.

BWA-MEM (0.7.15-r1140)
~~~~~~~~~~~~~~~~~~~~~~

Burrows-Wheeler Aligner is available from http://bio-bwa.sourceforge.net/. Extract the downloaded tarball, then move into that directory:

::

  tar -zxvf ~/Downloads/bwa-whatever.tar.bz2
  cd ~/Downloads/bwa-whatever/

Inside this directory, we will compile the source code into the binary executable:

::

  ./configure
  make
  make install

This is the standard trio of commands to configure a source for your system, make the binary, and install the binary. A file, 'bwa', will appear in the current directory after successful compilation. Move this binary to your Builds folder, and add that directory to your $PATH.

Samtools (1.3.1)
~~~~~~~~~~~~~~~~

Samtools is available from http://samtools.sourceforge.net/. Installation is identical to that of BWA-MEM. Extract the downloaded tarball, and move into the newly extracted directory. Configure, make and make install. Copy the new samtools binary to your Builds directory, and add it to your $PATH.

Picard (2.18.3)
~~~~~~~~~~~~~~~~

Picard can be downloaded from https://broadinstitute.github.io/picard/.

.. warning::
    Depending on which shell environment your operating system uses as default (or whichever shell you have chose to use), aliases may not be correctly read from your user profile by the bourne shell, which is the environment utilised by python's subprocess module. In order to account for this, modifications to how ScaleHD interacts with Picard were made as of version 0.31.

Previously, ScaleHD interacted with Picard via a user-generated bash alias. However, throughout more robust testing of different environments, we encountered certain combinations of operating systems and shell environments being unable to successfully get the required information for aliases to function. As such, we have changed (as of ScaleHD v0.31) how we interact with this program.

The user must create a unix script, which handles input arguments and launches the Picard JAR. An example script will look like the following:

::

  java -jar /Users/alastairm/Documents/Builds/Picard/picard.jar CreateSequenceDictionary REFERENCE=$1 OUTPUT=$2

As usual, replace the literal directory with your own Builds path. Save this as a file (with no extension) called 'picard'. Include this in the same folder as the Picard JAR, so that your ~/Builds/Picard folder looks like:

| Builds
| ├── Picard
| │   ├── picard ##the binary script we just made
| │   ├── picard.jar ##the download jar archive

Then, make our script executable:

::

  chmod +x /Users/alastairm/Documents/Builds/Picard/picard

Once made executable, add the Picard folder to your $PATH. Picard is now set-up for ScaleHD.

FreeBayes (v1.1.0-60-gc15b070)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FreeBayes has also been included within the SNP calling module of ScaleHD. Throughout development and testing, we observed a stronger performance of amplicon flanking sequence SNP detection with freebayes, and as such, the output of this binary is treated with more prominance in ScaleHD. Freebayes is available on github at https://github.com/ekg/freebayes. The readme for that repository contains installation instructions, which consists of a standard make/make install. It is also available for download from Homebrew, for easier installation on OS X.

Once installed (assuming via Homebrew, or by installing to /usr/local/bin with 'sudo make install'), the binary will be on your $PATH and ready for use by ScaleHD.

Virtual Environments
~~~~~~~~~~~~~~~~~~~~

Virtual Environments allow a Python user to create a separate terminal environment, which is separate from the 'main' environment of the operating system, but acts in an identical manner. This allows you to create an environment for a specific purpose, e.g. installing specific versions of packages that you did not wish to overwrite in your 'main' environment. This is useful if you have certain Python packages installed for other projects, which require a different version than that of ScaleHD.

To read up on Virtual Environments, we recommend reading this tutorial: http://docs.python-guide.org/en/latest/dev/virtualenvs/.

Common Issues
~~~~~~~~~~~~~

When colleagues were testing the software, these were the most common issues encountered when installing and/or running ScaleHD. If you're having trouble installing ScaleHD, hopefully an answer to your issue will be here.

 * LibXML headers missing

For this issue, you are missing the libxml2-dev and libxslt-dev libraries from your system. These packages should be installed as part of lxml, which is included in the setup script for ScaleHD, and should have been installed automatically. However, you can check if you are missing this package by opening a terminal, launching the Python interpreter (run the command 'python'), and then trying the command 'import lxml'. If this fails, then you know the package did not install properly, for whatever reason.

To remedy this, you can install lxml 'manually' from pip:

::

 STATIC_DEPS=true sudo pip install lxml

This command will require an internet connection, as it will download the sources for each developer library and build them for you, hopefully resolving any issues you have with lxml.

 * LibXML parsing error stack

As of the time of writing, there is no functionality within ScaleHD to check the structural integrity of your XML configuration files used, outside of the validity of provided attribute flags. If you have malformed XML, such as misplaced tags, ScaleHD will not launch and you will be greeted with a debug stack from lxml failing to parse invalid XML. Please check your XML and try running ScaleHD again.

 * SciPy stack errors

Sometimes the SciPy stack installs incorrectly from PIP, or fails quietly (i.e. the install failed, but claimed it was successful). If this is the case for you, we recommend installing the SciPy stack at a user level.

::

  pip install --user numpy scipy cython matplotlib

If this still refuses to work, you can look into installing these dependencies via Homebrew (see: https://brew.sh/).

::

  brew tap homebrew/science && brew install python numpy scipy matplotlib

ScaleHD on Windows
~~~~~~~~~~~~~~~~~~

Natively, ScaleHD has no support for Windows operating systems. However, with Windows 10, Microsoft has provided a way by which to run a unix environment on your Windows computer.
This allows ScaleHD to run on Windows machines, through this Linux Subsystem Layer. The Linux Subsystem is only available for Windows 10, versions 1709 and later. Other versions of Windows are not supported.

To install the Linux Subsystem:

Open PowerShell (search for the application in the start menu), and type the following command:

::

  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

This will require a reboot of your system to complete.

Once complete, you need to choose a linux distribution to install to your newly installed unix subsystem. Unfortunately you must do this
via the Windows Store, because yay for unnecessary homogenisation. Open the Windows Store, and search for your distribution. We have tested ScaleHD on Windows 10 only in ubuntu 18.04.

Once installed, you can open a command prompt (cmd.exe) to begin. Launch your installed distribution's shell. For our example:

::

  ubuntu1804

This changes your prompt from a Windows shell to the Ubuntu Bash environment. From here, you can follow ScaleHD installation instructions as above.
