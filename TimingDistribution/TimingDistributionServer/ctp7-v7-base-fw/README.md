# ctp7-v7-base-fw
Base Firmware for CTP7 Virtex-7 FPGA

# dev-board-examples

Development Board Firmware/Software Examples

# Before you clone the GIT repository

1) Create a github account:
> https://github.com/

2) On the Linux machine that you will clone the github from, generate a SSH key (if not already done)
> https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

3) Add a new SSH key to your GitHub account
> https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/

4) Setup for large filesystems on github

```
$ git lfs install
```

5) Verify that you have git version 2.13.0 (or later) installed 

```
$ git version
git version 2.13.0
```

6) Verify that you have git-lfs version 2.1.1 (or later) installed 

```
$ git-lfs version
git-lfs/2.1.1
```

# Clone the GIT repository

```
$ git clone --recursive git@github.com:uwcms/ctp7-v7-base-fw.git
```

# How to build the firmware 

1) Setup Xilinx environment

>  
```
$ source /opt/Xilinx/Vivado/2018.2/settings64.sh
```

2) Create a build directory (temporary Vivado project files)

```
$ cd ctp7-v7-base-fw
$ mkdir build
```
3) Go to the firmware directory and make the firmware:

```
$ cd firmware
$ make
```

4) Optional: Review the results in GUI mode
```
$ make gui
```

