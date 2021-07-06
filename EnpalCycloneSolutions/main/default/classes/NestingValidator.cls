/* Name : NestingValidator
 * Purpose : validate if the input value is properly nested 
 			 in terms of '()' or '{}' or '[]' & combination.
			 Principle used - First In Last Out of chars when iterating.
 * Author : Vinay Srinivasa
 * Date : 01/07/20201
 * Scope : Enpal - Technical Challenge
 **/

public class NestingValidator {
    
    public static Boolean isProperlyNested(String input) {
        
        // Map with keys as opening brackets and value as closing brackets
        Map<String, String> openBracMap = new Map<String, String>();
        openBracMap.put('(', ')');
        openBracMap.put('{', '}');
        openBracMap.put('[', ']');
        
        // Set used to check if the char has closing brackets
        Set<String> closBracSet = new Set<String>(openBracMap.values());
        
        // List to hold corresponding closing bracket for every opening
        List<String> matchList = new List<String>();
        Boolean isNested = true;
        
        //iterate through every char from input Value
        for (String character : input.split('')) {
            
            if (openBracMap.containsKey(character)) { // if opening bracket add corresponding value to list
                matchList.add(openBracMap.get(character));
            } 
            else if (closBracSet.contains(character)) { // if closing bracket check last char in list for same
                
                String balChar;
                if(matchList.isEmpty()){
                    balChar = Null;
                } else{
                    balChar = matchList.remove(matchList.size()-1);
                }
                if (character != balChar) {
                    // brackets are not nested and stop iterating
                    isNested = false;
                    break;
                }
            }
        }
        return isNested && matchList.isEmpty();
    }
}