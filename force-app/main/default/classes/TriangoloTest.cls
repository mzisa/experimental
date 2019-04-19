@isTest
public class TriangoloTest {
	@IsTest static Double calcolaArea() {
        Double base = 5;
        Double altezza = 3;
        
        Triangolo t = new Triangolo(base, altezza);
        return t.area();
    }
}