# The Beginning

If this were a novel, It probably would have started years ago. In reality I have built my homelab and rebuilt it dozens of times in the past twenty years. Too long, I have gone without committing... ;) 

to a true infrastructure that is <s>reputable</s> repeatable. 

This is that journey for me here. This project will incorporate exactly zero AI or LLMs code as I seek to build the infrastructure that serves my needs best and allows for a few different considerations. 

## Goals for the HomeLab

1. <b>Accessibility:</b> I have multiple devices, I want to be able to use them all to do a myriad of tasks from mobile to the desktop at home or away. 
2. <b>Security:</b> This is my my home infrastructure but security is my day job and my bread and butter so I will be aiming for security in every possible place. 
3. <b>Simplicity:</b> It is tremendously easy to build something that gets abandoned. This project is aiming to be the antithesis of that but actually enable disaster recovery. 
4. <b>Resiliency:</b> Day one I will not achieve this, but getting my infrastructure toward kubernetes and cloud level resiliency is important for the experience
5. <b>Cool Points:</b> Building services that further enable my life and create a platform to deliver and mature configurations that suit my many projects. 

## Getting Started

I currently have a linux device that will be the main server and all initial services will be spawned on this device for the time being. I am certain it can handle the basics and run concurrent services alone for the time being. It is custom and yes I built it myself originally as my main gaming machine but has now been relegated to the workhorse. 
```
 ADMIN@NUNYA
 ---------------
  OS: Ubuntu 24.04.3 LTS x86_64
  Kernel: 6.14.0-37-generic
  Shell: bash 5.2.21
  CPU: Intel i7-10700K (16) @ 5.300GHz
  GPU: NVIDIA GeForce RTX 3080 Ti
  Memory: 6061MiB / 48071MiB

```
## Its working...

Insert Phantom Menace GIF here. 

I have a device. I have an OS. I have SSH. <br>
I have an IDE. I have Git. I have GitHub. 
<br>
I have Docker. Now I must learn to use it. 
<p>

## Homepage

Homepage. Frontpage. Dashboard. all my future services will become accessible here and therefore it is prudent I have a landing page and a consistent space with which to access them. A Bookmarks bar simply is not enough anymore and this will be my key starting point. I set this up with docker compose.

https://gethomepage.dev/installation/docker/

### Key features
- <b>Quick Launch:</b> Just type and I can search for services or google directly
- <b>Organized Links:</b> Infrastructure, projects, bookmarks, this is now my landing page for new tabs.
- <b>Services Status:</b> Once I get more services I can expand 

## Portainer

While Docker is something I have worked with for quite some time ina simple sense I haven't yet graduated to swarms or kubernetes and Portainer seems like a great product to cut my teeth on. Seeing the stacks, volumes, and networking simplifies the docker capabilities for me.

In the future I am looking forward to exploring more container registries and learning about hardening containers. 