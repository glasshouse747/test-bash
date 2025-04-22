default:
	git pull
	ansible-playbook -i $(app_name)-dev.mydevops.shop, -e ansible_user=azuser -e ansible_password=Giveme123456 -e role_name=$(app_name) roboshop.yml