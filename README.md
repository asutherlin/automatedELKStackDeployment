## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[Red_Team_Cloud_Training.png](Diagrams/Red_Team_Cloud_Training.png) Diagram

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

[Docker_ps_output.png](Ansible/Docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines: 
- Web1vm = 10.1.0.8
- Web2vm = 10.1.0.9
 
We have installed the following Beats on these machines:
- [Filebeat](Ansible/filebeat-playbook.yml)
- [Metricbeat](Ansible/metricbeat-playbook.yml)

These Beats allow us to collect data from these machine.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook and it's configuration file to your /etc/ansible directory.
- Update the configuration file for the playbook to include the ELKvm IP address and set the user name and password.
- Update the playbook file to include a command to download the Beat file via `curl` and add the drop source/destination.
- Run the playbook, and navigate to http://<ELKvm IP Address>:5601/app/kibana/ dashboard to check that the installation worked as expected.

Here's a look at the Ansible [Filebeat-playbook.yml](Ansible/filebeat-playbook.yml) file:

  ```
  ---
- name: installing and launching filebeat
  hosts: webservers, elk
  become: true
  tasks:

  - name: download filebeat deb
    command: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.4.0-amd64.deb

  - name: install filebeat deb
    command: dpkg -i filebeat-7.4.0-amd64.deb

  - name: drop in filebeat.yml
    copy:
      src: /etc/ansible/install-filebeat/filebeat-config.yml
      dest: /etc/filebeat/filebeat.yml

  - name: enable and configure system module
    command: sudo filebeat modules enable system

  - name: Setup filebeat
    command: sudo  filebeat setup

  - name: start filebeat service
    command: sudo service filebeat start

  - name: enable service filebeat on boot
    systemd:
      name: filebeat
      enabled: yes
  ```
  
