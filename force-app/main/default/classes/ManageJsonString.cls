public class ManageJsonString {
	public static List<ArticoloJson> responseManager(String response) {
        List<ArticoloJson> output = (List<ArticoloJson>) System.JSON.deserialize(response, List<ArticoloJson>.class);
        return output;
    }
}