# dmilyasov_infra
dmilyasov Infra repository

Host bastion
  Hostname 35.210.201.224
  User appuser
  IdentityFile /root/.ssh/appuser

Host someinternalhost
  Hostname 10.132.0.6
  User appuser
  ProxyCommand ssh -W %h:%p bastion
  IdentityFile /root/.ssh/appuser

bastion_IP = 35.210.201.224
someinternalhost_IP = 10.132.0.6
testapp_IP = 34.91.63.229
testapp_port = 9292

#Ansible
#Реализован простой плейбук, клонирующий в vm репозиторий
