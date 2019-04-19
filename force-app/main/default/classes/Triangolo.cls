public class Triangolo {
    private Double base;
    private Double altezza;
    
	public Triangolo(Double b, Double a)
    {
        base = b;
        altezza = a;
    }
    
    public Double area() {
        return (base * altezza) / 2;
    }
}