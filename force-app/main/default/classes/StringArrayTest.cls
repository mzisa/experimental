public class StringArrayTest {
    public static List<String> generateStringArray(Integer occurrences) {
        List<String> generated = new List<String>();
        
        for (Integer counter=0; counter < occurrences; counter++)
        {
            String instance = 'Test ' + String.valueOf(counter);
            generated.add(instance);
        }
        
        return generated;
    }
}