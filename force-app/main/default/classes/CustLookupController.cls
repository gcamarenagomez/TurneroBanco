public class CustLookupController {
    
    @AuraEnabled
    public static List<RecordsData> fetchRecords(String objectName, String filterField, String searchString, String value){
        try{
            List<RecordsData> recordsDataList = new List<RecordsData>();
            String query = 'SELECT Id, Name, ' + filterField + ' FROM '+objectName;
            if(String.isNotBlank(value)) {
                query += ' WHERE Id = \''+ value + '\' LIMIT 49999';
            } else {
                query += ' WHERE '+filterField+
                    ' = ' + Decimal.valueOf(searchString.trim()) + ' LIMIT 49999';
            }
            for(SObject s : Database.query(query)) {
                System.debug(s.get(filterField));
                recordsDataList.add( new RecordsData((String)s.get('Name'), (String)s.get('id')) );
            }
            return recordsDataList;
        }
        catch(Exception err){
            if ( String.isNotBlank( err.getMessage() ) && err.getMessage().contains( 'error:' ) ) {
                throw new AuraHandledException(err.getMessage().split('error:')[1].split(':')[0] + '.');
            } else {
                throw new AuraHandledException(err.getMessage());
            }
        }
    }
    
    public class RecordsData{
        @AuraEnabled public String label;
        @AuraEnabled public String value;
        
        public RecordsData(String label, String value){
            this.label = label;
            this.value = value;
        }
    }
    
}