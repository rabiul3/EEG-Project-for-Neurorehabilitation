Descrizione della cartella e delle varie sottocartelle

File script .m:
-setup_averaging_conditions.m: file di configurazione per scegliere medie per il CSP(da modificare prima di lanciare qualsiasi altro script).
 
- run_csp.m: script principale per il metodo CSP di classificazione. Lanciare questo script per iniziare la classificazione EEG

-disp_csp_results.m: script che mostra i risultati di una classificazione fatta; lanciare questo script dopo che l'esecuzione di "run_csp_with_cov_averaging" 
 sia conclusa o dopo aver caricato un vecchio workspace con i risultati dell'esecuzione di quello script.
 
 Cartelle
 
 SCMs: contiene tutte le matrici SCM di varie competition e di vari soggetti.
 CSP_func: contiene script e funzioni utili al metodo CSP di classificazione, richiamate dallo script principale "run_csp_with_cov_averaging"
 Averaging_func: contiene tutte le funzioni per calcolare le varie medie
 Workspaces CSP: contiene i salvataggi degli workspace successivi all'esecuzione di "run_csp_with_cov_averaging". Utili per velocizzare la visualizzazione di risultati in ogni momento.
 Results: file di testo che mostra i risultati ottenuti.
 
 

 