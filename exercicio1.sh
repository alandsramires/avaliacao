#!/bin/bash
clear
echo "Digite quantos anos de idade você tem: "
read idade; echo
echo "Digite quantos meses de idade você tem: "
read mes;echo
echo "Digite quantos dias de idade  você tem: "
read dia;echo
echo -n "Calculando";sleep 1;echo -n ".";sleep 1;echo -n ".";sleep 1;echo  "."; echo
if (( $mes > 12 )); then
	echo "Valor informado para mes acima de 12. Entrada Incorreta!"	
	else
		if (( $dia > 365 ));then 
			echo "Valor informado para dia acima de 365. Entrada Incorreta!"
			else
				let anoparadia=($idade*365)
				let mesparadia=($mes*30)
				let res=($anoparadia+$mesparadia+$dia)
				echo "Sua idade em dias é: $res"
		fi
fi
echo
