# Variables à personnaliser
EMAIL ?= thomastrepant@gmail.com
GITHUB_USER ?= TotoD3V
REPO ?= Stage_seconde

ssh-key:
	@if [ ! -f ~/.ssh/id_ed25519 ]; then \
		echo "Génération d'une nouvelle clé SSH..."; \
		ssh-keygen -t ed25519 -C "$(EMAIL)" -f ~/.ssh/id_ed25519 -N ""; \
	else \
		echo "Clé SSH existante détectée."; \
	fi

ssh-agent:
	@eval "$$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519

show-pubkey:
	@echo "Voici votre clé publique à ajouter à GitHub :"
	@cat ~/.ssh/id_ed25519.pub
	@echo "\nAllez sur https://github.com/settings/keys pour l'ajouter."

set-remote:
	@git remote set-url origin git@github.com:$(GITHUB_USER)/$(REPO).git
	@echo "Remote modifié pour utiliser SSH."

test-ssh:
	@ssh -T git@github.com || true

all: ssh-key ssh-agent show-pubkey set-remote test-ssh
	@echo "\nVotre configuration SSH GitHub est terminée !"