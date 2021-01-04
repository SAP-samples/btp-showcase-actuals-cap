using dwc.odata as db from '../db/schema';

service EN {
    view CONS_ACTUALS_HDI as select from db.CONS_ACTUALS_HDI;
}

service CV {
    view EN_CONS_X_PROD_ACTUALS as select from db.EN_CONS_X_PROD_ACTUALS;
}