/* Name : NestingValidator_Test
 * Purpose : Test Class for NestingValidator
 * Author : Vinay Srinivasa
 * Date : 04/07/20201
 * Scope : Enpal - Technical Challenge
 **/
@isTest
public class NestingValidator_Test {
        
    @isTest
    public static void validateBracs(){
        List<String> valueList = new List<String>();
        Map<Integer,String> openBracsMap = new Map<Integer,String>();
        Map<Integer,String> closeBracsMap = new Map<Integer,String>();
        
        String s1 = '{{{{}}}}';
        String s2 = '}]][[{';
        system.assert(NestingValidator.isProperlyNested(s1) == True, 'Value is nested');
        system.assert(NestingValidator.isProperlyNested(s2) == False, 'Value is not nested properly');
               
    }
}