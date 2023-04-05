// Write a trigger on Lead object to fix the Annual revenue as per the Industry field.

trigger FirstTriggerOnLead on Lead ( before insert, before update ) {
    if( trigger.isbefore && ( trigger.isInsert || trigger.isUpdate ))
        for( Lead ld : trigger.new ) {
            switch on ld.industry {
                when 'Banking'
                {
                    ld.annualRevenue = 100000;
                }
                when 'Agriculture'
                {
                    ld.annualRevenue = 300000;
                }
                when 'Apparel'
                {
                    ld.annualRevenue = 500000;
                }
                 when 'Biotechnology'
                {
                    ld.annualRevenue = 700000;
                }
                 when 'Chemicals'
                {
                    ld.annualRevenue = 900000;
                }
                 when 'Construction'
                {
                    ld.annualRevenue = 1100000;
                }
            }
        }
    }