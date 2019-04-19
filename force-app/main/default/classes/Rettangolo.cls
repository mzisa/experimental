public class Rettangolo {
    private Double base;
	private Double altezza;
    
    public Rettangolo(Double pBase, Double pAltezza) {
        try {
        	base = pBase;
        	altezza = pAltezza;
        
        	if (base < 0 || altezza < 0)
        	{
            	throw new ParametriNonValidiException();
        	}
        }
        catch(ParametriNonValidiException ex) {
            System.debug('Base e altezza non possono essere negativi');
        }
    }
    
    public Double area()
    {
        if (base == altezza)
        {
            return (base * base);
        }
        else
        {
			return (base * altezza);            
        }
    }
    
    public Double perimetro() {
        return (base * 2 + altezza * 2);
    }
    
    public class ParametriNonValidiException extends Exception {}
}