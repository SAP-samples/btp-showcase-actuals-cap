namespace dwc.odata;

@cds.persistence.exists 
Entity  ![CONS_ACTUALS_HDI] {
    key    ![YEAR_]: Integer  @title: 'YEAR_' ; 
    key    ![MONTH_]: String(2)  @title: 'MONTH_' ; 
    key    ![DAY_]: String(2)  @title: 'DAY_' ; 
    key    ![HOUR_]: String(2)  @title: 'HOUR_' ; 
    key    ![MINUTE_]: String(2)  @title: 'MINUTE_' ; 
           ![WEEKNUM_]: String(2)  @title: 'WEEKNUM_' ; 
           ![WEEKDAY_]: Integer  @title: 'WEEKDAY_' ; 
           ![WEEKEND_YN_]: String(1)  @title: 'WEEKEND_YN_' ; 
           ![UNIT]: String(3)  @title: 'UNIT' ; 
           ![RECORDMODE]: String(5000)  @title: 'RECORDMODE' ; 
           ![EN_CONS_ACTUAL]: Decimal(17, 0)  @title: 'EN_CONS_ACTUAL' ; 
}

@cds.persistence.exists 
Entity ![EN_CONS_X_PROD_ACTUALS] {
    key     ![YEAR_]: Integer  @title: 'YEAR_' ; 
    key     ![MONTH_]: String(2)  @title: 'MONTH_' ; 
    key     ![DAY_]: String(2)  @title: 'DAY_' ; 
    key     ![HOUR_]: String(2)  @title: 'HOUR_' ; 
    key     ![MINUTE_]: String(2)  @title: 'MINUTE_' ; 
            ![WEEKNUM_]: String(2)  @title: 'WEEKNUM_' ; 
            ![WEEKDAY_]: Integer  @title: 'WEEKDAY_' ; 
            ![WEEKEND_YN_]: String(1)  @title: 'WEEKEND_YN_' ; 
            ![UNIT]: String(3)  @title: 'UNIT' ; 
            ![EN_CONS_ACTUAL]: Decimal(17, 0)  @title: 'EN_CONS_ACTUAL' ; 
            ![EN_PROD_ACTUAL]: Decimal(17, 0)  @title: 'EN_PROD_ACTUAL' ; 
}