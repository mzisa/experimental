global class FattureWS {
    WebService static List<Fattura> getFatture(String codiceOrdine) {
    	List<Fattura> elencoFatture = new List<Fattura>();
    	Fattura fat = null;

        if (codiceOrdine.Equals('ORD001'))
        {
            fat = new Fattura('Desktop Acer', 100, 799, 'ORD001');
            elencoFatture.Add(fat);

            fat = new Fattura('Stampante HP', 200, 199, 'ORD001');
            elencoFatture.Add(fat);

            fat = new Fattura('Laptop Microsoft Surface', 300, 999, 'ORD001');
            elencoFatture.Add(fat);

            fat = new Fattura('Tablet Lenovo', 400, 299, 'ORD001');
            elencoFatture.Add(fat);

            fat = new Fattura('Kindle Paperwhite', 500, 199, 'ORD001');
            elencoFatture.Add(fat);

            fat = new Fattura('Mouse Logitech', 600, 79, 'ORD001');
            elencoFatture.Add(fat);

            fat = new Fattura('Xbox One', 700, 399, 'ORD001');
            elencoFatture.Add(fat);

            fat = new Fattura('Playstation 4', 800, 389, 'ORD001');
            elencoFatture.Add(fat);

            fat = new Fattura('Televisore Samsung HD', 900, 899, 'ORD001');
            elencoFatture.Add(fat);

            fat = new Fattura('Lavatrice Whirlpool', 950, 499, 'ORD001');
            elencoFatture.Add(fat);
        }
        else
        {
            fat = new Fattura('Desktop Acer Lux', 100, 899, 'ORD002');
            elencoFatture.Add(fat);

            fat = new Fattura('Stampante HP Lux', 200, 299, 'ORD002');
            elencoFatture.Add(fat);

            fat = new Fattura('Laptop Microsoft Surface4', 300, 1199, 'ORD002');
            elencoFatture.Add(fat);

            fat = new Fattura('Tablet Lenovo Lux', 400, 399, 'ORD002');
            elencoFatture.Add(fat);

            fat = new Fattura('Kindle Paperwhite Lux', 500, 299, 'ORD002');
            elencoFatture.Add(fat);

            fat = new Fattura('Mouse Logitech Lux', 600, 99, 'ORD002');
            elencoFatture.Add(fat);

            fat = new Fattura('Xbox Two', 700, 599, 'ORD002');
            elencoFatture.Add(fat);

            fat = new Fattura('Playstation 5', 800, 489, 'ORD002');
            elencoFatture.Add(fat);

            fat = new Fattura('Televisore Samsung Ultra HD', 900, 1099, 'ORD002');
            elencoFatture.Add(fat);

            fat = new Fattura('Lavatrice Whirlpool 10kG', 950, 699, 'ORD002');
            elencoFatture.Add(fat);
        }

		return elencoFatture;
    }
}