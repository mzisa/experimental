public class ScaricoProdottiMagazzinoController {
	private static Map<String, String> areeStock = new Map<String, String>{'001' => 'Containers','002' => 'Casse','003' => 'Pallet groups','004' => 'Fusti',
        															'005' => 'Piattaforme','006' => 'Catena del freddo','007' => 'Deperibili'};
    private static Map<String, String> codProvenienza = new Map<String, String>{'ITA' => 'Italia','USA' => 'Stati Uniti','DEN' => 'Danimarca','GER' => 'Germania'};
    private static Map<String, String> codTipologia = new Map<String, String>{'001' => 'Alimentari','002' => 'Tabacchi','003' => 'Elettronica'};
    private static List<Dipendenza> dipendenze = new List<Dipendenza>{
        new Dipendenza('002','DEN','001',301,400),
        new Dipendenza('002','GER','002',401,500),
        new Dipendenza('002','ITA','003',501,600),
        new Dipendenza('003','USA','003',601,700),
        new Dipendenza('003','ITA','004',801,900),
        new Dipendenza('003','USA','005',701,800),
        new Dipendenza('003','ITA','005',901,999),
        new Dipendenza('001','USA','006',1,200),
        new Dipendenza('001','ITA','007',201,300)
    };
    
    private class Dipendenza
    {
        String tipologia;
        String provenienza;
        String codiceAreaStock;
        Integer minPallet;
        Integer maxPallet;
        private Dipendenza(String t,String p,String c,Integer min,Integer max)
        {
            this.tipologia=t;
            this.provenienza=p;
            this.codiceAreaStock=c;
            this.minPallet=min;
            this.maxPallet=max;
        }
    }
    
    @ReadOnly @RemoteAction 
    public static String getDateDiRiferimento()
    {
		String ret = '';
        List<AggregateResult> pm = [SELECT Data_di_acquisto__c FROM Prodotto_Magazzino__c GROUP BY Data_di_acquisto__c ORDER BY Data_di_acquisto__c DESC];
        Set<String> anni = new Set<String>();
        for (AggregateResult p:pm)
        {
            Date d = (Date)p.get('Data_di_acquisto__c');
            anni.add(String.valueOf(d.year()));
        }
        Boolean primo = true;
        for (String anno:anni)
        {
			if (primo)
            {
                ret += anno;
                primo=false;
            }
            else ret += ','+anno;
        }
        return ret;        
    }
    
    @ReadOnly @RemoteAction 
    public static String getAreeStock(String tipologia, String provenienza)
    {
		String ret = '';
        Set<String> listaAreeStock = new Set<String>();
        Boolean perTipologia = (tipologia!='Qualsiasi');
        Boolean perProvenienza = (provenienza!='Qualsiasi');
        Boolean perTipologiaEProvenienza = (perTipologia && perProvenienza);
        for (Dipendenza d:dipendenze)
        {
            if (perTipologiaEProvenienza)
            {
                if (codTipologia.get(d.tipologia)==tipologia && codProvenienza.get(d.provenienza)==provenienza) 
                    if (!listaAreeStock.contains(areeStock.get(d.codiceAreaStock)))
                        	listaAreeStock.add(areeStock.get(d.codiceAreaStock));
            }
            else
            {
                if (perTipologia)
                {
                    if (codTipologia.get(d.tipologia)==tipologia) 
                        if (!listaAreeStock.contains(areeStock.get(d.codiceAreaStock)))
                        	listaAreeStock.add(areeStock.get(d.codiceAreaStock));
                }
                if (perProvenienza)
                {
                    if (codProvenienza.get(d.provenienza)==provenienza)
                        if (!listaAreeStock.contains(areeStock.get(d.codiceAreaStock)))
                        	listaAreeStock.add(areeStock.get(d.codiceAreaStock));
                }
            }
        }
        Boolean primo = true;
        for (String areaStock:listaAreeStock)
        {
            if (primo)
            {
                ret += areaStock;
                primo=false;
            }
            else ret += ','+areaStock;
        }
        return ret;        
    }
    
    @ReadOnly @RemoteAction 
    public static String getCodicePallet(String tipologia,String provenienza,String areaStock)
    {
        String ret = '';
        List<AggregateResult> pm = new List<AggregateResult>();
        if (tipologia!='Qualsiasi')
            pm = [SELECT Codice_Pallet__c FROM Prodotto_Magazzino__c
                  WHERE Descrizione_tipologia__c=:tipologia AND
                  Descrizione_provenienza__c=:provenienza AND
                  Descrizione_area_di_stoccaggio__c=:areaStock
                  GROUP BY Codice_Pallet__c ORDER BY Codice_Pallet__c LIMIT 100];
        else
            pm = [SELECT Codice_Pallet__c FROM Prodotto_Magazzino__c
                  WHERE Descrizione_provenienza__c=:provenienza AND
                  Descrizione_area_di_stoccaggio__c=:areaStock
                  GROUP BY Codice_Pallet__c ORDER BY Codice_Pallet__c LIMIT 100];
        Boolean primo = true;
        for (AggregateResult p:pm)
        {
            if (primo)
            {
                ret += p.get('Codice_Pallet__c');
                primo=false;
            }
            else ret += ','+p.get('Codice_Pallet__c');
        }
        return ret;
    }
    
    @ReadOnly @RemoteAction 
    public static String getExcel(String data,String tipologia,String provenienza,String areaStock,String codPallet)
    {
        PageReference pr = new PageReference('/resource/TemplateScaricoExcel/TemplateScarico.txt');
        Blob content = pr.getContent();
        String ret= content.toString();
        ret=ret.replace('ZZZAUTOREZZZ', UserInfo.getName());
        ret=ret.replace('ZZZDATACREAZIONEZZZ', System.now().year() + '-' + 
                        System.now().month() + '-' +
                        System.now().day() + 'T' + 
                        System.now().hour() + ':' +
                        System.now().minute() + ':' +
                        System.now().second() + 'Z');
        String query = 'SELECT Codice_area_di_stoccaggio__c,Codice_Pallet__c,Codice_provenienza__c,Codice_tipologia__c,Data_di_acquisto__c,Descrizione__c,'+
            			'Descrizione_area_di_stoccaggio__c,Codice_Pallet__c,Descrizione_provenienza__c,Descrizione_tipologia__c,Nome__c '+
            			'FROM Prodotto_Magazzino__c ';
        Date dataMin = date.newInstance(Integer.valueOf(data), 1, 1);
        Date dataMax = date.newInstance(Integer.valueOf(data), 12, 31);
        query += 'WHERE Data_di_acquisto__c>='+String.valueOf(dataMin)+' AND Data_di_acquisto__c<='+String.valueOf(dataMax);
        ret = ret.replace('ZZZFILTRODATAZZZ', data);
        if (tipologia!='Qualsiasi')
        {
            query+= ' AND Descrizione_tipologia__c= \''+tipologia+'\'';
            ret=ret.replace('ZZZFILTROTIPOLOGIAZZZ', tipologia);
        }
        else ret=ret.replace('ZZZFILTROTIPOLOGIAZZZ', 'Qualsiasi');
        if (provenienza!='Qualsiasi')
        {
            query+= ' AND Descrizione_provenienza__c= \''+provenienza+'\'';
            ret=ret.replace('ZZZFILTROPROVENIENZAZZZ', provenienza);
        }
        else ret=ret.replace('ZZZFILTROPROVENIENZAZZZ', 'Qualsiasi');
        if (areaStock!='Qualsiasi' && !String.isBlank(areaStock))
        {
            query+= ' AND Descrizione_area_di_stoccaggio__c=\''+areaStock+'\'';
            ret=ret.replace('ZZZFILTROAREASTOCKZZZ', areaStock);
        }
        else ret=ret.replace('ZZZFILTROAREASTOCKZZZ', 'Qualsiasi');
        if (codPallet!='Qualsiasi' && !String.isBlank(codPallet))
        {
            query+= ' AND Codice_Pallet__c=\''+codPallet+'\'';
            ret=ret.replace('ZZZFILTROPALLETZZZ', codPallet);
        }
        else ret=ret.replace('ZZZFILTROPALLETZZZ', 'Qualsiasi');
        query+= ' ORDER BY Data_di_acquisto__c';
        List<Prodotto_Magazzino__c> prodotti = (List<Prodotto_Magazzino__c>)Database.query(query);
        if (prodotti.size()==0) return null;
        ret=ret.replace('ZZZNPRODOTTIZZZ', String.valueOf(prodotti.size()));
        String righeDati = '';
        for (Prodotto_Magazzino__c prodotto:prodotti)
        {
            righeDati += '   <Row>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+String.valueOf(prodotto.Data_di_acquisto__c)+'</Data></Cell>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Nome__c+'</Data></Cell>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Codice_tipologia__c+'</Data></Cell>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Descrizione_tipologia__c+'</Data></Cell>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Codice_provenienza__c+'</Data></Cell>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Descrizione_provenienza__c+'</Data></Cell>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Codice_area_di_stoccaggio__c+'</Data></Cell>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Descrizione_area_di_stoccaggio__c+'</Data></Cell>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Codice_Pallet__c+'</Data></Cell>\r\n';
            righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Descrizione_Pallet__c+'</Data></Cell>\r\n';
            if (prodotto.Descrizione__c==null) righeDati += '    <Cell><Data ss:Type="String"></Data></Cell>\r\n';
            else righeDati += '    <Cell><Data ss:Type="String">'+prodotto.Descrizione__c+'</Data></Cell>\r\n';
            righeDati += '   </Row>\r\n';
        }
        ret= ret.replace('   ZZZDATAZZZ\r\n', righeDati);
        return ret;
    }
}