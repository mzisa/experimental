public class Quadrato {
	private Double lato;
    
    public Quadrato(Double l) {
        lato = l;
    }
    
    public Double area()
    {
        return (lato * lato);
    }
    
    public Double perimetro() {
        return (lato * 4);
    }	
}