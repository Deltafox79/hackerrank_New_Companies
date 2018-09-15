using MySql.Data.MySqlClient;
using System;

namespace Companies
{
    //Per il test ho usato un database locale sul Pc nello Specifico un Mysql v8.0.12 e phpmyadmin 4.8.3
    //Ho Installato ed usato il riferimento dll "MySql.Data.dll" per l'interfacciamento al Database
    //cosi Ottenuto dal file mysql-installer-community-8.0.12.0.msi
    //Ho Creato le table/data come richiesto onde effettuare i test trovate il file Sql in allegato su GitHub
    class Program
    {
        //New Companies Problem - Solution By DeltaFoX aka Russo Paolo Rito  
        static void Main(string[] args)
        {
            //Inizializzo la Stringa di Connessione al database locale companies che ho creato ed ometto la password per ovvie ragioni
            string connectionString = "datasource=127.0.0.1;port=3306;username=root;password=xxxxxx;database=companies;";
            //Qui Imposto la query per la richiesta analizziamola
            //1) Effettuo una Select sulla tabella company -> comapany_code e company founder
            //2) da qui richiamo le 4 select per il relativo conteggio dei 4 valori richiesti usando la DISTINCT per evitare duplicati
            //3) su ognuna di queste select effettuo il count ne verifico il relativo company_code con il principale company.company_code
            //4) ad ogni select assegno un alias per meglio identificarli in tabella
            //5) raggruppo il tutto per company -> comapany_code e company founder
            //6) Ordino per il Valore company.company_code che verifico dal primo carattere per renderlo numerico con min(xxx) come richiesto
            string query = "SELECT company.company_code, company.founder, (SELECT COUNT(DISTINCT lead_manager_code) " +
                "from lead_manager where lead_manager.company_code = company.company_code) as ToT_lead_managers," +
                " (SELECT COUNT(DISTINCT senior_manager_code) from senior_manager where senior_manager.company_code = company.company_code) " +
                "as ToT_senior_managers, (SELECT COUNT(DISTINCT manager_code) from manager where manager.company_code = company.company_code)" +
                " as ToT_managers, (SELECT COUNT(DISTINCT employee_code) from employee where employee.company_code = company.company_code) " +
                "as ToT_employee FROM company GROUP BY company.company_code, company.founder " +
                "ORDER BY min(substring(company.company_code,1,length(company.company_code)) ) ASC";
            //Inizializzo le variabili di comunicazione mysql con il database locale 127.0.0.1 o localhost
            MySqlConnection databaseConnection = new MySqlConnection(connectionString);
            //passo la query settata precedentemente
            MySqlCommand commandDatabase = new MySqlCommand(query, databaseConnection);
            //Imposto un valore minimo di Timeout
            commandDatabase.CommandTimeout = 60;
            //Inizializzo la variabile Reader
            MySqlDataReader reader;
            //sezione try/Catch per evntuali errori
            try
            {
                //Apro la connesisone con Il database locale
                databaseConnection.Open();
                //Eseguo la query
                reader = commandDatabase.ExecuteReader();
                //Verifico se in risposta ho colonne
                if (reader.HasRows)
                {
                    //Inizio il ciclo while sulla variabile reader per verificare tutte le possibili risposte in ritorno
                    while (reader.Read())
                    {
                        //Ciclo for su tutti i valori ottenuti dalla query ed richiedo il relativo numero di colonne
                        for (int i = 0; i < reader.FieldCount; i++)
                            Console.Write(reader.GetString(i) + " "); // Printo a video i valori Ottenuti in linea
                        Console.WriteLine("");
                    }
                }
                else
                {
                    //In Caso di nessun risultato printo a video
                    Console.WriteLine("No rows found.");
                }
                //Chiudo la connessione con il Database Locale
                databaseConnection.Close();
                Console.ReadLine();
            }
            catch (Exception ex)
            {
                //In caso di errore Printo a video l'errore segnalato
                Console.WriteLine(ex.Message);
                //Attendo Input da parte Utente per chiudere la win della Console
                Console.ReadLine();
            }
        }
    }
}
