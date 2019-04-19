public class ArticoloComplexJson {
	public String Codice_articolo;
	public String Descrizione;
	public Integer Prezzo;
	public Integer Quantita;
	public Provenienza[] Provenienza;
	public class Provenienza {
		public String Paese;
		public Integer TempoArrivo;
	}
	public static ArticoloComplexJson parse(String json){
		return (ArticoloComplexJson) System.JSON.deserialize(json, ArticoloComplexJson.class);
	}
}