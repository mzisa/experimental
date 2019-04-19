@isTest
public class RettangoloTest {
    @IsTest static Double calcolaArea() {
        Double base = 5;
        Double altezza = 3;
        
        Rettangolo r = new Rettangolo(base, altezza);
        return r.area();
    }
    
    @IsTest static Double calcolaAreaComeQuadrato() {
        Double base = 5;
        Double altezza = 5;
        
        Rettangolo r = new Rettangolo(base, altezza);
        return r.area();
    }
    
    @IsTest static Double calcolaPerimetro() {
        Double base = 5;
        Double altezza = 3;
        
        Rettangolo r = new Rettangolo(base, altezza);
        return r.perimetro();
    }
    
    @isTest static void baseAltezzaNegativi() {
        Double base = -5;
        Double altezza = 3;
        
        Rettangolo r = new Rettangolo(base, altezza);
    }
}