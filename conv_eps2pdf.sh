#!/bin/bash
# Converte tutti i file eps, in una directory data nel formato "pdf".
# Viene utilizzato l'eseguibile "ps2pdf"
OPERAZIONE=epstopdf
ESTENSIONE=pdf # estensione finale dei nomi dei file.
if [ -n "$1" ]
then
	directory=$1 # Se viene fornito il nome di una directory come argomento dello script
else
	directory=$PWD # Altrimenti viene utilizzata la directory corrente
fi
# Si filtrano tutti i file nella directory affinché siano dei eps con estensione ".eps"
for file in $( find $directory -type f -name '*.eps' | sort )
   do
	nomefile=${file%.*s} # Toglie estensione ".eps" dal nome del file
	$OPERAZIONE $file > "$nomefile.$ESTENSIONE" # Converte i file in pdf
echo "$nomefile.$ESTENSIONE" # Visualizza quello che avviene allo stdout.
done
# Si filtrano tutti i file nella directory affinché siano dei pdf con estensione ".pdf"
for file in $( find $directory -type f -name '*.pdf' | sort )
   do
	nomefile=${file%.*f} # Toglie estensione ".pdf" dal nome del file
	pdftk $file cat 1 output "$nomefile" # toglie la pag 2 nel file e lo lascia senza est .pdf
echo "$nomefile.$ESTENSIONE" # Visualizza quello che avviene allo stdout.
done
# Si filtrano tutti i file nella directory affinché siano dei pdf con estensione ".pdf"
for file in $( find $directory -type f -name '*.pdf' | sort )
   do
	nomefile=${file%.*f} # Toglie estensione ".pdf" dal nome del file
	rm -f $file # Cancella i file pdf originali, quelli con la pagina 2
	mv "$nomefile" "$nomefile.$ESTENSIONE" # Aggiunge ai file l'estensione .pdf
done
exit 0