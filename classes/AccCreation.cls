public class AccCreation {
    public static void newAccountRecords() {
        try{
        List<Account> accList= new List<Account>();
        for( Integer i=0 ; i<20 ; i++ ) {
            Account act1_upd=new Account();
            act1_upd.Name = 'PaiCopa'+i+'Rajath';
            act1_upd.Fax = '123paicopa';
            act1_upd.Website='https://twitter.com';
            accList.add(act1_upd);
        }
        if(accList.size() > 0) {
            insert  accList;
        }
    }
    catch(Exception ex){

    }
    }
}