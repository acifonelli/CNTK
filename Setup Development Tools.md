# Update Visual Studio 2017 Workloads and Components
Your current VS installation can be updated via `Visual Studio Installer`, clicking on the related `Modify` button.
* *Workloads*:
    * Desktop development with C++;
    * .NET desktop development;
    * Universal Windows Platform development;
    * Python development.
* *Components*:
    * VC++ 2017 version 15.4 v14.11 toolset;
    * Visual C++ runtime for UWP;
    * Windows 10 SDK (10.0.16299.0) for Desktop C++ [x86 and x64];
    * Windows 10 SDK (10.0.16299.0) for UWP: C#, VB, JS;
    * Windows 10 SDK (10.0.16299.0) for UWP: C++.

# Update CMake Installation
CNTK 2.6 version requires a CMake version >=3.8 to compile some of its dependencies (e.g. protobuf 3.10).  
You can download the last release for Windows [here](https://github.com/Kitware/CMake/releases/download/v3.13.2/cmake-3.13.2-win64-x64.msi).  
Before installing the new version, uninstall any previous CMake version.

# NVIDIA CUDA 10.0
You can download the last released toolkit [here](https://developer.nvidia.com/compute/cuda/10.0/Prod/network_installers/cuda_10.0.130_win10_network).

# Add `VS2017INSTALLDIR` Environment Variable
You can add an environment variable from the Control Panel or launching the following command in a command prompt  
`setx VS2017INSTALLDIR "C:\Program Files (x86)\Microsoft Visual Studio\2017\<offering>"`  
replacing `<offering>` with the type of VS you have on your machine (e.g. Community, Enterprise, etc.).

# Clone the CNTK Repository and Install the Development Tools
Open a Git Bash, navigate to the location where you want to store the repository and give the following commands
```
git clone https://github.com/acifonelli/CNTK.git
mv CNTK CNTK-2-6
cd CNTK-2-6
git submodule update --init external/gsl
git submodule update --init Source/CNTKv2LibraryDll/proto/onnx/onnx_repo
git submodule update --init Source/CNTKv2LibraryDll/proto/onnx/onnxruntime/
git submodule update --init -- Source/Multiverso
```

If you already have `Anaconda` installed on your machine and the `cntk-py35` activated, delete it as we need to
create again a new virtual environment with all the development tools needed.

Now open a Git CMD window and fire the command `start powershell -executionpolicy remotesigned`. This will open a new PowerShell window.  
Inside the just created PowerShell instance launch `InstallDevTools.ps1` and follows the on-screen instructions. Once the task is  
complete you can quit the PowerShell window.

# Compile the solution
We are almost done.  
Open a command prompt window, if you don't have one already, and locate the `prebuild.bat` file (it should be in Source\\CNTKv2LibraryDll)  
and launch it. It will produce the `buildinfo.h` file.  
Open the `CNTK.sln` solution, change the target to `Release` (it means w/ GPU support) and `x64` architecture.  
Compile the solution.

# Troubleshooting

## Graphic Card Not Working Properly or `No elegible device found` Error
Windows can raise an issue regarding the signature of the display drivers coming with CUDA 10.  
We can easily check that if we observe an odd behaviour on our screen(s) and in the `Device Manager` section of the Control Panel.  
The issue is easily solved downloading the last version of the display drivers directly from the NVIDIA [site](https://www.nvidia.com/Download/index.aspx?lang=en-us#)

## ipykernel-post-link.bat Exits with Error while Creating `cntk-py35` Environment
This can be related to a missing `PYTHONPATH` environment variable or a broken/not up-to-date Anaconda installation.  
In the first case just type `setx PYTHONPATH "full_path_to_python"` in a command prompt and hit enter.  
In the latter case follow these steps
```
conda update -n root --all
conda update conda
conda update --all
```
finally run again the `InstallDevTools.ps1` script.

## `LNK1181 cannot open input file Multiverso.lib`
This is not a major problem if we want to build CNTK from scratch and we don't need the Distributed Machine Learning Toolkit.  
If we need the DMLT we have to change the environment variable `CNTK_ENABLE_ASGD` to `true`. Then we can open the  
`Mutiverso.sln` with `Visual Studio 2013` and compile the solution to generate the library.