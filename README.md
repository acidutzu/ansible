--- provision all the nodes that are found in the inventory file with a SSH key type ed25519
that was first generated manualy on a MAIN machine with ssh-keygen -t ed25519 -C "ansible" command

use this line below to copy the public ssh key that is stored in ~/.ssh/id_ed25519.pub on the MAIN machine
to all the nodes via ssh by skipping the RSA finger print question



ansible-playbook deploy_keys.yml --ask-pass -i inventory


--- skipping the fingerprint question is made by using this: host_key_checking = False  in ansible.cfg
