public class ManageXmlString {
	public static List<Articolo> responseManager(String response, String recordNode) {
        List<Articolo> output = new List<Articolo>();
        Dom.Document doc = new Dom.Document();
        doc.load(response);
        Dom.XmlNode root = doc.getRootElement();
        List<Dom.Xmlnode> body = root.getChildElements();
        
        for (Dom.Xmlnode outputInstance : body) {
            if (outputInstance.getName().Equals(recordNode)) {
            	List<Dom.Xmlnode> recordFields = outputInstance.getChildElements();
            	output.add(processRecord(recordFields));
            }
        }
        return output;
    }
    private static Articolo processRecord(List<Dom.Xmlnode> singleRecord) {
    	Articolo articolo = new Articolo();
    	articolo.Codice_articolo = singleRecord[0].getText().trim();
    	articolo.Descrizione = singleRecord[1].getText().trim();
    	articolo.Prezzo = Integer.valueOf(singleRecord[2].getText().trim());
    	articolo.Quantita = Integer.valueOf(singleRecord[3].getText().trim());
    	return articolo;
    }
}