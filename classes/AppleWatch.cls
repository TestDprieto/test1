Public with sharing Class AppleWatch{
 Public Static void appleWatchmethod(list<Opportunity> lopt ){
    for (Opportunity opp : lopt) {
    /* from dev1 to uat */
        Task t        = new Task();
        t.Subject     = 'Apple Watch Promo';
        t.Description = 'Send them one ASAP';
        t.Priority    = 'High';
        t.WhatId      = opp.Id;
        insert t;
     }
  }
  /* aug 6th*/
 }