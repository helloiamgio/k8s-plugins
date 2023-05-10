
# backup k8s

I backup proposti da mirantis sono:

1. backup UCP
2. backup DTR
3. backup swarm

4. CapGemini utilizza uno script per il salvataggio della configurazione dei vari oggetti. Lo script è stato ereditato.

## approfondimento

I backup 1,2,3 vengono salvati nella cartella identificata dal data del giorno (la destinazione è definita in common.sh).

I 4 backup sono inseriti al momento in crontab (commentati) di root su parma, su grpd-kb1-pv00 per 1,3,4 e su grpd-kb-pv27 per 2.

Lo script 1 viene lanciato su un master via curl a vip, un master a caso se ne occupa, salvando poi localmente (nella directory condivisa su NFS a permesso RW per tutti). Il contenuto viene poi spostato nella cartella destinazione scelta.

Lo script DTR, è eseguibile solo sui nodi in cui è effettivamente presente il DTR (27,28,29 al momento).

Il backup di swarm viene eseguito al momento a caldo (senza lo spegnimento del master), ma è consigliato da Mirantis l'esecuzione a freddo. Perchè si possa effettuare a freddo, è necessario verificare che vi siano 2/3 dei nodi disponibili, attivi e funzionanti. Un controllo viene effettivamente effettuato, ma non viene al momento spento il nodo in quanto la procedura è rischiosa.

## sicurezza

- la directory in cui vengono piazzati i backup (DESTDIR in common.sh) è leggibile solo da root
- la directory backup che contiene gli script è di root e leggibile solo da root
- lo script common.sh che contiene alcune informazioni sensibili è di root rwx------
- il backup 4 di capgemini raccoglie una serie di files di configurazioni che vengono inseriti in un repository git (di root)
  con tagging (YYMMDD-HHMM) in modo da assicurarsi non vi siano modifiche inappropriate e consentire una facile verifica via git diff

## TODO

- parametrizzare per kb1 e kb2
- alcuni script funzionano solo sui master, altri solo su DTR (27,28,29). Alcune verifiche vengono aggiunte
- introdurre HA anche sugli script (lanciati su più nodi)
- valutazione del backup a freddo di swarm


