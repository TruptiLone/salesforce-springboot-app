public class TimeFormat {
    public String changeTimeFormat(String strTime) {
  String finalTime;
  String hrStr = strTime.SubStringBefore(':');
  String minStr = strTime.SubStringAfter(':');
  Integer hrInt = integer.valueof(hrStr);
  String str;
  String str1;
  Integer hh;
  // Finding out the Meridien of time
    // ie. AM or PM
    string Meridien;
    if (hrInt < 12) {
        Meridien = 'AM';
    }
    else{
        Meridien = 'PM';
    }
        

  hh = Math.Mod(hrInt, 12);
        if(hh<10){
         str =  String.valueOf(hh);
           finalTime = '0'+str + ':' + minStr+' ' + Meridien; 
            system.debug('Final time is : '+finalTime);
        }else{
          finalTime = str + ':' + minStr+' ' + Meridien;
        system.debug('Final time is : '+finalTime);
        }
	//str =  String.valueOf(hh);
        
    //finalTime = str + ':' + minStr+' ' + Meridien;
        //system.debug('Final time is : '+finalTime);
    return finalTime;

}

}