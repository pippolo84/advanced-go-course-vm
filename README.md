# Advanced Go Course - Virtual Machine Test

<br />

This repository contains a Vagrantfile and a provision script similar to the
one we will use for the upcoming Advanced Go Course.

The full course material will be available shortly before the first day of
lesson, October 28 2021.

In the meantime, I suggest you to give this script a try and report any issue
you experience with it. We will try our best to help you ahead of the course.

To report a problem, just open an issue here on this repository.
To fix a problem, just open a PR (thanks in advance!).

To test the virtual machine, you will need to clone this repo:

```
git clone https://github.com/pippolo84/advanced-go-course-vm
```

Then:

- [Install VirtualBox][install-virtualbox]
- [Install Vagrant][install-vagrant]
- Run `vagrant up` from the repository root to provision the VM
- Get a shell on the VM by running `vagrant ssh`

Once logged in the virtual machine, execute:

`go version`

and you should see that Go 1.17.1 is available.

To follow all the course contents and try all the examples, I suggest to use
the virtual machine.
This way, you will get rid of all the possible annoyances that may come up
configuring all the tools.

Anyway, the vast majority of the material and all the exercises will not
require anything more than a recent version of Go installed plus some packages.

So, If you'd like to set up your machine or if you experience some issues with
the VM, don't panic, you will be able to get the most out of the course either
way.

To manually setup your machine, I suggest to take a look at the `provision.sh`.
At the minimum, These are the things you should have to do the exercises:

- [Install Go][install-go]
- [Install Delve][install-delve]

[install-go]: http://golang.org/dl
[install-delve]: https://github.com/go-delve/delve/tree/master/Documentation/installation
[install-virtualbox]: https://www.virtualbox.org/wiki/Downloads
[install-vagrant]: https://www.vagrantup.com/downloads