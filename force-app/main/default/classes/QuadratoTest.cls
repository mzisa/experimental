@isTest
public class QuadratoTest {
    @IsTest static Double calcolaArea() {
        Double lato = 5;
        
        Quadrato q = new Quadrato(lato);
        return q.area();
    }
    
    @IsTest static Double calcolaPerimetro() {
        Double lato = 5;
        
        Quadrato q = new Quadrato(lato);
        return q.perimetro();
    }
}