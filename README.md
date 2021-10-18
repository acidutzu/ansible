<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<meta name="generator" content="LibreOffice 7.0.4.2 (Linux)"/>
</head>
<body lang="en-US" link="#000080" vlink="#800000" dir="ltr"><p>---------------------------------------------------------------------------------</p>
<p>--- provisioning nodes | deploy ssh ed25519 public key to all nodes</p>
<p><i>		First step:</i></p>
<p>- add nodes/hosts</p>
<p>example from: nano /etc/hostnames</p>
<p>192.168.1.131 clone1 
</p>
<p>192.168.1.132 clone2 
</p>
<p>... ... . ... ..... 
</p>
<p>192.168.1.135 clone5</p>
<p style="margin-bottom: 0in; line-height: 100%">or nano
<i>etc/ansible/hosts</i></p>
<p style="margin-bottom: 0in; line-height: 100%"><br/>

</p>
<p style="margin-bottom: 0in; line-height: 100%"><i>		Second step:</i></p>
<p><br/>
<br/>

</p>
<p>--- provision all the nodes that are found in the inventory file
with a SSH key type ed25519 that was first generated manualy on a
MAIN machine with:<br/>
<br/>
<br/>

</p>
<p><b>ssh-keygen -t ed25519 -C &quot;ansible&quot;</b></p>
<p>next:</p>
<p>- use this line below to copy the public ssh key that is stored in
~/.ssh/id_ed25519.pub on the MAIN machine to all the nodes via ssh by
skipping the ECDSA finger print question</p>
<p><b>ansible-playbook deploy_keys.yml --ask-pass -i inventory</b></p>
<p>--- skipping the fingerprint question is made by using this:
host_key_checking = False in ansible.cfg 

	---names clone1 clone2 ...clone5
from inventory file are hostnames which are found on MAIN machine in
/etc/hostnames</p>
<p>------------------------------------------------------------------</p>
<p><i>		Last step:</i></p>
<p>run install_docker.yml playbook to automate instalation of docker, docker-compose, docker hello_wolrd image
and ctop, <br/>
it will ask for sudo password</p>
<p><b>ansible-playbook install_doker.yml --ask-become-pass -i
inventory</b></p>
<p><br/>
<br/>

</p>
</body>
</html>
