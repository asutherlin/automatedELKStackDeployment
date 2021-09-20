## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Red Team Cloud Training](Diagrams/Red_Team_Cloud_Training.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook files may be used to install only certain pieces of it, such as Filebeat.

  - Example playbook: [install-elk.yml](Diagrams/install-elk.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly effecient, in addition to restricting DDoS attacks to the network.

The Jump Box Provisioner has the sole responsibility to provide updates on the storage area network without having to update each virtual machine connected to the resource group.


Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.

["Filebeat monitors the log files or locations that you specify, collects log events, and forwards them either to Elasticsearch or Logstash for indexing."](https://www.elastic.co/guide/en/beats/filebeat/current//filebeat-overview.html)

["Metricbeat takes the metrics and statistics that it collects and ships them to the output that you specify, such as Elasticsearch or Logstash."](https://www.elastic.co/guide/en/beats/metricbeat/7.14/metricbeat-overview.html#:~:text=Metricbeat%20takes%20the%20metrics%20and,HAProxy)

| Name     | Function | IP Address       | Operating System |
|----------|----------|------------------|------------------|
| Jump Box | Gateway  | Client IP        | Linux            |
| Web-1    | Host     | 10.1.0.8         | Linux            |
| Web-2    | Host     | 10.1.0.9         | Linux            |
| ELKvm    | ELK Host | 10.1.0.6         | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet.

Only the Jump Box Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: _Client IP_


Machines within the network can only be accessed by the DVWA Docker Container. 
- [install-dvwa.yml](dvwa-playbook.yml)

The Jump Box Provisioner's IP is the only machine allowed to access the ELKvm: _40.83.166.154_

A summary of the access policies in place can be found in the table below.

| Name               | Publicly Accessible | Allowed IP Addresses |
|--------------------|---------------------|----------------------|
| Jump Box           | No                  | Client IP            |
| JumpToVNet         | No                  | 10.1.0.6             |
| HomeToVNet         | No                  | Client IP            |
| SSHtoELKVM         | No                  | Any                  |
| AllowPort5601toELK | No                  | Client IP            | 

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because the process entire becomes streamlined from start to install all on it's own. 

- [install-elk.yml](Diagrams/install-elk.yml)

```
---
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: azadmin
  become: true
  tasks:
    - name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker.io
        state: present

    - name: Install python3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

    - name: Install Docker module
      pip:
        name: docker
        state: present

    - name: Increase virtual memory
      command: sysctl -w vm.max_map_count=262144

    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: 262144
        state: present
        reload: yes

    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        published_ports:
          -  5601:5601
          -  9200:9200
          -  5044:5044

    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes
```
The playbook implements the following tasks:
- First is to install docker.io to create a container within the ELKvm.
- Next, Python3 is installed so that the vm has a way to run the Kibana/Elastic scripts for Metricbeat and Filebeat.
- Increase the virtual memory of the vm to 262,144bytes
- Download the docker_containter image for ELK stack: _sebp/elk:761_ and always start/restart on boot.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker_ps_output.png](Ansible/Docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring_

We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._% 
