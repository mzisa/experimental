global class Fattura {
	String Descrizione = '';
    Integer Quantita = 0;
    Integer Prezzo = 0;
    String CodiceOrdine = '';

	public Fattura(String d, Integer q, Integer p, String c)
    {
        this.Descrizione = d;
        this.Quantita = q;
        this.Prezzo = p;
        this.CodiceOrdine = c;
    }
}