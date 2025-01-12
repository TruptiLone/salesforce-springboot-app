public class TestFormat {
    public void nameFromEmail(String email) {

	String firstname;
	String lastname;
    String uppercasefirstname;
    String uppercaselastname;
	String lowercasefirstname;
    String lowercaselastname;

	firstname = email.substringBefore('.');
    lastname = email.substringBetween('.','@');
    
    lowercasefirstname = firstname.substring(1,firstname.length()).toLowerCase();
	lowercaselastname =  lastname.substring(1,lastname.length()).toLowerCase();
    
    system.debug('String is'+' '+lowercasefirstname +' '+lowercaselastname);  
	
    uppercasefirstname = firstname.substring(0,1).toUpperCase()+lowercaselastname;
	uppercaselastname = lastname.substring(0,1).toUpperCase()+lowercaselastname;
        
	system.debug('String is'+' '+uppercasefirstname +' '+uppercaselastname);

	//return firstname +' '+lastname;

}

}