#!/bin/bash
#Autor: Alan Ramires - Analista de Infraestrutura
#Data de criação: 03/05/2017 13:12
escolha=10
clear

while (( $escolha != 0 )); do

escolha=$(dialog --menu "Escolha uma das opções abaixo:" 20 45 7 \
1 "Criar novo usuário" \
2 "Alterar senha" \
3 "Deletar usuário" \
4 "Criar grupo" \
5 "Incluir usuário ao grupo" \
6 "Alterar a permissão de pasta" \
0 "Sair" --stdout)

	if (( $escolha == 1 )); then
		nome=$(dialog --inputbox "Digite um nome para o novo usuário a ser criado:" 20 35 --stdout)
		useradd $nome -s /bin/MySecureShell -m
		senha=$(dialog --title "Senha"  --passwordbox "Digite a senha"  20 35 --stdout)
		senha2=$(dialog --title "Senha" --passwordbox "Digite a senha novamente"  20 35 --stdout)
		if [  $senha != $senha2 ]; then
			dialog --title "Erro" --msgbox "As senhas informadas não conferem. Por favor, tente novamente!" 20 35
				else
					echo "$nome:$senha" | chpasswd
					dialog --title "Sucesso" --infobox  "Usuário $nome criado com sucesso!" 20 35
					sleep 3
		fi
	fi

	if (( $escolha == 2 )); then
		nome=$(dialog --inputbox "Digite o nome do usuario:" 20 35 --stdout)
		senha=$(dialog --title "Senha" --passwordbox "Digite a nova senha" 20 35 --stdout)
		senha2=$(dialog --title "Senha" --passwordbox "Digite a senha novamente" 20 35 --stdout)
		if (( $senha != $senha2 )); then
			dialog --title "Erro" --msgbox "As senhas informadas não conferem. Por favor, tente novamente!" 20 35 --stdout
				else
					echo "$nome:$senha" | chpasswd
					dialog --title "Sucesso" --infobox "Usuário $nome teve sua senha atualizada!" 20 35
					sleep 3 
		fi		
	fi

	if (( $escolha == 3 )); then
		nome=$(dialog --title "Exclusão" --inputbox "Digite o nome do usuario a ser excluído!" 20 35 --stdout)
		dialog --title "Confirmação" --yesno "Deseja realmente excluir o usuário $nome?" 20 35 --stdout
		if [ $? = 0 ]; then
			userdel $nome
			dialog --title "Confirmação" --infobox "Usuário $nome excluído com sucesso!" 20 35 --stdout 
			sleep 2	
				else 
					dialog --title "Cancelada" --infobox "Operação Cancelada" 20 35 --stdout
					sleep 2
		fi		
	fi


	if (( $escolha == 4 )); then
		grupo=$(dialog --title "Grupos" --inputbox "Escreva um nome para o novo grupo a ser criado:" 20 35 --stdout)
		groupadd $grupo
		dialog --title "Confirmação" --infobox "Grupo $grupo criado com sucesso!" 20 35 --stdout
		sleep 2
		
	fi

	if (( $escolha == 5 )); then
		nome=$(dialog --title "Usuário" --inputbox "Digite o nome do usuário:" 20 35 --stdout)
		grupo=$(dialog --title "Grupo" --inputbox "Digite o nome do grupo:" 20 35 --stdout)
		gpasswd -a $nome $grupo
		dialog --title "Confirmação" --infobox "Usuario $nome incluido no grupo $grupo com socesso!" 20 35 --stdout
		sleep 2

	fi

	if (( $escolha == 6 )); then
		caminho=$(dialog --title "Caminho" --inputbox "Digite o caminho absoluto da pasta a ser alterada suas permissões: (Exemplo: /home/suporte01" 20 35 --stdout)
		permissao=$(dialog --title "Permissao" --inputbox "Digite a permissão que deseja atribuir a esta pasta em decimal: (Exemplo: 770)" 20 35 --stdout)
		chmod -R $permissao $caminho
		dialog --title "Confirmação" --infobox "Permissões da pasta $caminho alteradas para $permissao com sucesso!" 20 35 --stdout
		sleep 4
	fi

done
clear
