Descrizione della cartella e delle varie sottocartelle

File script .m:
-setup_averaging_conditions.m: file di configurazione per scegliere medie su cui calcolare 
 gli spazi tangenti e fare la classificazione.(da modificare prima di lanciare qualsiasi altro script).
 
- run_TSM.m: script principale per il metodo TSM di classificazione. Lanciare questo script per iniziare la classificazione EEG

-disp_results.m: script che mostra i risultati di una classificazione fatta; lanciare questo script dopo che l'esecuzione di "run_TSM_with_cov_averaging" 
 sia conclusa o dopo aver caricato un vecchio workspace con i risultati dell'esecuzione di quello script.

- disp_confusion_matrices.m: script che mostra tutte le matrici di confusione di un soggetto partendo da un workspace salvato dell'algoritmo TSM

- plot_confusion_matrices.m: script che mostra il plot di una matrice di confusione di un soggetto (specificare il soggetto, e la media su cui è applicato l'algoritmo TSM )
 
-find_worst_best_mean.m: script per trovare la media migliore e peggiore dato il vettore di accuratezza e la matrice delle distanze


 Cartelle
 
 SCMs: contiene tutte le matrici SCM di varie competition e di vari soggetti.
 TSM_func: contiene script e funzioni utili al metodo TSM di classificazione, richiamate dallo script principale "run_TSM_with_cov_averaging"
 Averaging_func: contiene tutte le funzioni per calcolare le varie medie
 Workspaces TSM: contiene i salvataggi degli workspace successivi all'esecuzione di "run_TSM_with_cov_averaging". Utili per velocizzare la visualizzazione di risultati in ogni momento.
 Confusion_Matrix_func: contiene le funzioni per calcolare le matrici di confusione ed organizzarle
 
 Results: file di testo che mostrano i risultati ottenuti.
 Descrizione di tali file:
 Results.txt: mostra i risultati "normali" dell'algoritmo di classificazione applicati ai vari dataset
 Results restricted class.txt: mostra i risultati per il dataset JKHH ristretti allo studio di 2 classi (come nella tesi)
 Results trimmed each class.txt: mostra i risultati ottenuti dai metodi trim. Però anziche calcolare la media tagliata su tutte le classi insieme, 
 viene una media tagliata per ogni classe e poi la media geometrica delle varie medie tagliate. Questo incrementa un po la percentuale di accuratezza.
 best worst averages.txt: file di testo che mostra per ogni soggetto ma media migliore e peggiore.
 
 Confusion Matrices Plot: cartella contenente le immagini delle matrici di confusione calcolate per uno specifico soggetto e una specifica media (descrizione nel nome stesso dell'immagine)
 
 
 

 