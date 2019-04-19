public class CreateJsonResourceController {
	public List<JsonResource.PrTipologia> elencoTipologie {get; set;}
	public List<JsonResource.PrRating> elencoRating {get; set;}
	public List<JsonResource.PrTipoLinea> elencoTipoLinea {get; set;}
	public List<JsonResource.PrProposte> elencoProposte {get; set;}

	public CreateJsonResourceController() {
		PageReference pr = new PageReference('/resource/JsonResources/Tipologie.json');
    	String content = pr.getContent().toString();
    	elencoTipologie = (List<JsonResource.PrTipologia>)JSON.deserialize(content,List<JsonResource.PrTipologia>.class);

    	pr = new PageReference('/resource/JsonResources/Rating.json');
    	content = pr.getContent().toString();
    	elencoRating = (List<JsonResource.PrRating>)JSON.deserialize(content,List<JsonResource.PrRating>.class);

    	pr = new PageReference('/resource/JsonResources/Tipolinea.json');
    	content = pr.getContent().toString();
    	elencoTipoLinea = (List<JsonResource.PrTipoLinea>)JSON.deserialize(content,List<JsonResource.PrTipoLinea>.class);

    	pr = new PageReference('/resource/JsonResources/Proposte.json');
    	content = pr.getContent().toString();
    	elencoProposte = (List<JsonResource.PrProposte>)JSON.deserialize(content,List<JsonResource.PrProposte>.class);
    }
}