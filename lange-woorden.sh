if [ ! -e lange-woorden.txt ]
then
	./alle-woorden.sh
fi
cat alle-woorden.txt|awk '{print length, $0}' | sort -rn | awk '{$1=""; print $0 }'>lange-woorden.txt
cat alle-woorden.txt|grep "^[12345\`qwertasdfgzxcvb]*$"|awk '{print length, $0}' | sort -rn | awk '{$1=""; print $0 }'>lange-woorden-linker-hand.txt
cat alle-woorden.txt|grep "^[67890\'yuiophjklnm\.-=]*$"|awk '{print length, $0}' | sort -rn | awk '{$1=""; print $0 }'>lange-woorden-rechter-hand.txt
head -n7 lange-woorden.txt lange-woorden-linker-hand.txt lange-woorden-rechter-hand.txt
