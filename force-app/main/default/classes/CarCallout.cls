public class CarCallout {
	public CarCallout(String modelloAuto, String tipoMotore) {
		CarSoapProxy.CarSoap carsoap = new CarSoapProxy.CarSoap();
		CarSoapProxy.CarInfo result = carsoap.GetCarInformation(modelloAuto, tipoMotore);
		System.debug('Alimentazione=' + result.Alimentazione);
		System.debug('StatoInCommercio=' + result.StatoInCommercio);
	}
}